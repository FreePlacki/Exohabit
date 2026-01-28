import 'package:exohabit/completions/completion_extensions.dart';
import 'package:exohabit/completions/completion_local_store.dart';
import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/habits/habit_repository.dart';
import 'package:exohabit/habits/habits_screen.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'completion_repository.g.dart';

final class HabitToday {
  HabitToday({
    required this.habit,
    required this.completedToday,
    required this.weeklyProgress,
  });

  final Habit habit;
  final bool completedToday;
  final int weeklyProgress;

  bool get weeklyGoalMet => weeklyProgress >= habit.row.frequencyPerWeek;
}

@riverpod
Stream<List<HabitToday>> todayHabits(Ref ref) {
  final habits = ref.watch(habitRepositoryProvider).watchHabits();
  final completionRepo = ref.watch(completionRepositoryProvider);
  ref.watch(completionsProvider);

  return habits.asyncMap((habits) async {
    final today = DateUtils.dateOnly(DateTime.now().toLocal());
    final todayEnd = DateUtils.dateOnly(
      DateTime.now().toLocal().add(const Duration(days: 1)),
    ).subtract(const Duration(seconds: 1));
    final weekStart = today.subtract(
      Duration(days: today.weekday - DateTime.monday),
    );

    final result = <HabitToday>[];

    for (final habit in habits) {
      final completedToday = await completionRepo.existsForDay(
        habit.id,
        todayEnd,
      );

      final weeklyProgress = await completionRepo.countDistinctDays(
        habit.id,
        from: weekStart,
        to: todayEnd,
      );

      result.add(
        HabitToday(
          habit: habit,
          completedToday: completedToday,
          weeklyProgress: weeklyProgress,
        ),
      );
    }

    return result;
  });
}

@Riverpod(keepAlive: true)
Stream<List<HabitWeekly>> weeklyHabits(Ref ref) {
  final habits = ref.watch(habitRepositoryProvider).watchHabits();
  final completionRepo = ref.watch(completionRepositoryProvider);
  ref.watch(completionsProvider);

  return habits.asyncMap((habits) async {
    final now = DateTime.now().toLocal();
    final today = DateUtils.dateOnly(now);

    final weekStart = today.subtract(
      Duration(days: today.weekday - DateTime.monday),
    );

    final result = <HabitWeekly>[];

    for (final habit in habits) {
      final completedDays = <bool>[];

      for (var i = 0; i < 7; i++) {
        final day = weekStart.add(Duration(days: i));
        final dayEnd = day
            .add(const Duration(days: 1))
            .subtract(const Duration(seconds: 1));

        final completed = await completionRepo.existsForDay(habit.id, dayEnd);

        completedDays.add(completed);
      }

      result.add(HabitWeekly(habit: habit, completedDays: completedDays));
    }

    return result;
  });
}

final completionsProvider = StreamProvider<List<Completion>>(
  (ref) => ref.watch(completionRepositoryProvider).watchCompletions(),
);

@riverpod
CompletionRepository completionRepository(Ref ref) =>
    CompletionRepository(localStore: ref.watch(completionLocalStoreProvider));

class CompletionRepository {
  CompletionRepository({required CompletionLocalStore localStore})
    : _localStore = localStore;

  final CompletionLocalStore _localStore;

  Future<List<Completion>> forDay(String habitId, DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return _localStore.forHabit(habitId, from: start, to: end);
  }

  Future<bool> existsForDay(String habitId, DateTime day) async {
    final l = await forDay(habitId, day);
    return l.isNotEmpty;
  }

  Future<int> countDistinctDays(
    String habitId, {
    required DateTime from,
    required DateTime to,
  }) => _localStore.countDistinctDays(habitId, from: from, to: to);

  Future<bool> complete(String habitId, DateTime date) async {
    if (await existsForDay(habitId, date)) {
      return false;
    }
    await _localStore.upsert(CompletionExtensions.create(habitId: habitId));
    return true;
  }

  Stream<List<Completion>> watchCompletions() => _localStore.watch();

  Stream<List<Completion>> watchUnsynced() => _localStore.watchUnsynced();
}
