import 'package:exohabit/habits/habit.dart';
import 'package:exohabit/habits/habit_repository.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_controller.freezed.dart';
part 'habit_controller.g.dart';

@freezed
abstract class HabitEditState with _$HabitEditState {
  const factory HabitEditState({required bool isSaving, String? error}) =
      _HabitEditState;
}

@riverpod
class HabitController extends _$HabitController {
  @override
  HabitEditState build() {
    return const HabitEditState(isSaving: false);
  }

  Future<void> submit({
    required Habit? existingHabit,
    required String title,
    required String description,
    required int frequency,
  }) async {
    state = state.copyWith(isSaving: true);

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      state = state.copyWith(
        isSaving: false,
        error: 'You must be logged in to save a habit.',
      );
      return;
    }

    final repo = ref.read(habitRepositoryProvider);

    try {
      if (existingHabit != null) {
        final habit = existingHabit.copyWith(
          title: title,
          description: description,
          frequencyPerWeek: frequency,
        );
        await repo.updateHabit(habit);
      } else {
        final habit = Habit.create(
          title: title,
          description: description,
          frequencyPerWeek: frequency,
        );
        await repo.createHabit(habit);
      }
    } catch (err) {
      state = state.copyWith(isSaving: false, error: err.toString());
      return;
    }

    state = state.copyWith(isSaving: false);
  }
}
