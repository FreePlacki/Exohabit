import 'package:exohabit/models/habit_completion.dart';

class CompletionService {
  /// Calculate weekly progress for a habit
  /// Returns the number of completions this week out of the target frequency
  int calculateWeeklyProgress(
      String habitId, int frequencyPerWeek, List<HabitCompletion> completions) {
    final thisWeekCompletions = getCompletionsThisWeek(habitId, completions);
    return thisWeekCompletions.length;
  }

  /// Check if a habit can be completed today (prevents duplicates)
  bool canCompleteToday(String habitId, List<HabitCompletion> todayCompletions) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    return !todayCompletions.any((completion) {
      final completedAt = completion.completedAt;
      return completedAt.isAfter(todayStart) && completedAt.isBefore(todayEnd);
    });
  }

  /// Get completions for the current week (Monday-Sunday)
  List<HabitCompletion> getCompletionsThisWeek(
      String habitId, List<HabitCompletion> allCompletions) {
    final now = DateTime.now();
    final weekStart = _getWeekStart(now);
    final weekEnd = weekStart.add(const Duration(days: 7));

    return allCompletions.where((completion) {
      final completedAt = completion.completedAt;
      return completedAt.isAfter(weekStart) &&
          completedAt.isBefore(weekEnd) &&
          completion.habitId == habitId;
    }).toList();
  }

  /// Get week start (Monday) for a given date
  DateTime _getWeekStart(DateTime date) {
    // ISO week: Monday is day 1, Sunday is day 7
    final weekday = date.weekday; // 1 = Monday, 7 = Sunday
    final daysFromMonday = weekday - 1;
    return DateTime(date.year, date.month, date.day).subtract(Duration(days: daysFromMonday));
  }
}

