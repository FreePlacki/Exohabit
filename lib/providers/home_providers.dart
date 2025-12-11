import 'package:exohabit/models/habit_completion.dart';
import 'package:exohabit/providers/completion_providers.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeStats {
  HomeStats({
    required this.todayCount,
    required this.weekCount,
    required this.weekGoal,
    required this.streakDays,
    required this.weekdayCounts,
    required this.habitsCount,
  });

  final int todayCount;
  final int weekCount;
  final int weekGoal;
  final int streakDays;
  final List<int> weekdayCounts; // Monday-first, length 7
  final int habitsCount;

  double get weeklyProgress =>
      weekGoal == 0 ? 0 : (weekCount / weekGoal).clamp(0, 1);
}

/// Derived home stats combining habits and their completion streams.
final homeStatsProvider = Provider<AsyncValue<HomeStats>>((ref) {
  final habitsAsync = ref.watch(habitsProvider);

  return habitsAsync.when(
    loading: () => const AsyncLoading(),
    error: (error, stack) => AsyncError(error, stack),
    data: (habitList) {
      // For each habit, watch its completions
      final completionAsyncs = habitList.map((habit) =>
        ref.watch(habitCompletionsProvider(habit.id))
      ).toList();

      // Check if any completion stream is still loading
      if (completionAsyncs.any((c) => c.isLoading)) {
        return const AsyncLoading();
      }

      // Check if any completion stream has an error
      final errorCompletions = completionAsyncs.where((c) => c.hasError);
      if (errorCompletions.isNotEmpty) {
        final errorCompletion = errorCompletions.first;
        return AsyncError(errorCompletion.error!, errorCompletion.stackTrace ?? StackTrace.current);
      }

      // All completion streams have data
      final completionLists = completionAsyncs.map((c) => c.value!).toList();

      // Flatten all completions
      final allCompletions = completionLists.expand((list) => list).cast<HabitCompletion>().toList();

      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final todayEnd = todayStart.add(const Duration(days: 1));

      final weekStart = _weekStart(now);
      final weekEnd = weekStart.add(const Duration(days: 7));

      final todayCount = allCompletions
          .where((c) => c.completedAt.isAfter(todayStart) && c.completedAt.isBefore(todayEnd))
          .length;

      final weekCompletions = allCompletions
          .where((c) => c.completedAt.isAfter(weekStart) && c.completedAt.isBefore(weekEnd))
          .toList();

      final weekCount = weekCompletions.length;
      final weekGoal = habitList.fold<int>(0, (sum, h) => sum + h.frequencyPerWeek);

      final weekdayCounts = List<int>.filled(7, 0);
      for (final c in weekCompletions) {
        final dayIndex = _weekdayIndex(c.completedAt);
        if (dayIndex != null) weekdayCounts[dayIndex] += 1;
      }

      final streakDays = _calculateStreak(allCompletions, todayStart);

      return AsyncData(HomeStats(
        todayCount: todayCount,
        weekCount: weekCount,
        weekGoal: weekGoal,
        streakDays: streakDays,
        weekdayCounts: weekdayCounts,
        habitsCount: habitList.length,
      ));
    },
  );
});

DateTime _weekStart(DateTime date) {
  final weekday = date.weekday; // 1 = Monday
  final daysFromMonday = weekday - DateTime.monday;
  return DateTime(date.year, date.month, date.day)
      .subtract(Duration(days: daysFromMonday));
}

/// Monday-first index (0-6) or null if outside current week.
int? _weekdayIndex(DateTime date) {
  final normalized = DateTime(date.year, date.month, date.day);
  final monday = _weekStart(normalized);
  final diff = normalized.difference(monday).inDays;
  if (diff < 0 || diff > 6) return null;
  return diff;
}

int _calculateStreak(List<HabitCompletion> completions, DateTime todayStart) {
  // Build a set of day keys (yyyy-mm-dd) where at least one completion exists.
  final dayKeys = <String>{};
  for (final c in completions) {
    final d = c.completedAt;
    final key = '${d.year}-${d.month}-${d.day}';
    dayKeys.add(key);
  }

  int streak = 0;
  DateTime cursor = todayStart;
  while (true) {
    final key = '${cursor.year}-${cursor.month}-${cursor.day}';
    if (dayKeys.contains(key)) {
      streak += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    } else {
      break;
    }
  }
  return streak;
}

