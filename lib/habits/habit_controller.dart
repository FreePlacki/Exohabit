import 'package:exohabit/habits/habit_category.dart';
import 'package:exohabit/habits/habit_extensions.dart';
import 'package:exohabit/habits/habit_repository.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_controller.g.dart';

final habitProvider = Provider.autoDispose.family<Habit?, String?>((ref, id) {
  return id == null
      ? null
      : ref.watch(
          habitsProvider.select((async) {
            final list = async.value;
            if (list == null) {
              return null;
            }

            for (final e in list) {
              if (e.id == id) {
                return e;
              }
            }
            return null;
          }),
        );
});

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
    required HabitCategory category,
  }) async {
    state = const AsyncLoading();

    final repo = ref.read(habitRepositoryProvider);

    state = await AsyncValue.guard(() async {
      if (existingHabit != null) {
        final habit = Habit(
          existingHabit.row.copyWith(
            title: title,
            description: description,
            frequencyPerWeek: frequency,
          ),
        );
        await repo.updateHabit(habit);
      } else {
        final habit = HabitExtensions.createHabit(
          title: title,
          description: description,
          frequencyPerWeek: frequency,
          category: category,
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
