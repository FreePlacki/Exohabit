import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/models/habit_completion.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:exohabit/services/completion_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final completionServiceProvider = Provider((ref) => CompletionService());

final habitCompletionsProvider = StreamProvider.family<List<HabitCompletion>, String>((ref, habitId) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const Stream.empty();

  final repo = ref.read(habitRepositoryProvider);
  return repo.getCompletionsForHabit(habitId, userId);
});

final weeklyProgressProvider = Provider.family<int, String>((ref, habitId) {
  final completions = ref.watch(habitCompletionsProvider(habitId));
  final habits = ref.watch(habitsProvider);
  
  return completions.when(
    data: (completionList) {
      final habit = habits.value?.firstWhere((h) => h.id == habitId);
      if (habit == null) return 0;
      
      final service = ref.read(completionServiceProvider);
      return service.calculateWeeklyProgress(habitId, habit.frequencyPerWeek, completionList);
    },
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final canCompleteTodayProvider = Provider.family<bool, String>((ref, habitId) {
  final completions = ref.watch(habitCompletionsProvider(habitId));
  
  return completions.when(
    data: (completionList) {
      final service = ref.read(completionServiceProvider);
      // Filter today's completions
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final todayEnd = todayStart.add(const Duration(days: 1));
      
      final todayCompletions = completionList.where((c) {
        final completedAt = c.completedAt;
        return completedAt.isAfter(todayStart) && completedAt.isBefore(todayEnd);
      }).toList();
      
      return service.canCompleteToday(habitId, todayCompletions);
    },
    loading: () => true, // Allow completion while loading
    error: (_, __) => true, // Allow completion on error
  );
});

