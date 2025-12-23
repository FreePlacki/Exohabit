import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habit_extensions.dart';
import 'package:exohabit/habits/habit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_controller.g.dart';

final habitsProvider = StreamProvider.autoDispose<List<Habit>>(
  (ref) => ref.watch(habitRepositoryProvider).watchHabits(),
);

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
        final habit = HabitExtensions.createHabit(
          title: title,
          description: description,
          frequencyPerWeek: frequency,
        );
        await repo.createHabit(habit);
      }
    });
  }

  Future<void> delete(Habit habit) async {
    state = const AsyncLoading();

    final repo = ref.read(habitRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await repo.deleteHabit(habit);
    });
  }
}
