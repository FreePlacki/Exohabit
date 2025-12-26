import 'package:exohabit/completions/completion_extensions.dart';
import 'package:exohabit/completions/completion_local_store.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habit_repository.dart';
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

  bool get weeklyGoalMet => weeklyProgress >= habit.frequencyPerWeek;
}

@riverpod
Stream<List<HabitToday>> todayHabits(Ref ref) {
  final habits = ref.watch(habitRepositoryProvider).watchHabits();
  final completionRepo = ref.watch(completionRepositoryProvider);
  ref.watch(completionsProvider);

  return habits.asyncMap((habits) async {
    final today = DateUtils.dateOnly(DateTime.now().toUtc());
    final weekStart = today.subtract(
      Duration(days: today.weekday - DateTime.monday),
    );

    final result = <HabitToday>[];

    for (final habit in habits) {
      final completedToday = await completionRepo.existsForDay(habit.id, today);

      final weeklyProgress = await completionRepo.countDistinctDays(
        habit.id,
        from: weekStart,
        to: today,
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

final completionsProvider = StreamProvider.autoDispose<List<Completion>>(
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

  Future<void> complete(String habitId, DateTime date) => _localStore.upsert(
    CompletionExtensions.create(habitId: habitId, completedAt: date),
  );

  Stream<List<Completion>> watchCompletions() => _localStore.watch();
}
