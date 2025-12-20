import 'package:exohabit/habits/habit.dart';
import 'package:exohabit/habits/habit_repository.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_controller.g.dart';

@riverpod
class HabitController extends _$HabitController {
  @override
  Future<void> build() async {}

  Future<void> submit({
    required Habit? existingHabit,
    required String title,
    required String description,
    required int frequency,
  }) async {
    state = const AsyncLoading();

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      state = AsyncError(
        'You must be logged in to save a habit.',
        StackTrace.current,
      );
      return;
    }

    final repo = ref.read(habitRepositoryProvider);

    state = await AsyncValue.guard(() async {
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
    });
  }
}
