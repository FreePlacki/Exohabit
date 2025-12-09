import 'package:exohabit/services/completion_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  final service = CompletionService();

  group('calculateWeeklyProgress', () {
    test('counts completions for the habit within the current week', () {
      final now = DateTime.now();
      final monday = now.subtract(Duration(days: now.weekday - 1));

      final completions = [
        buildCompletion(
          habitId: 'habit-1',
          completedAt: monday.add(const Duration(days: 1)),
        ),
        buildCompletion(
          habitId: 'habit-1',
          completedAt: monday.add(const Duration(days: 2)),
        ),
        buildCompletion(
          habitId: 'habit-2',
          completedAt: monday.add(const Duration(days: 2)),
        ),
        buildCompletion(
          habitId: 'habit-1',
          completedAt: monday.add(const Duration(days: 8)), // Next week
        ),
      ];

      final result = service.calculateWeeklyProgress(
        'habit-1',
        3,
        completions,
      );

      expect(result, 2);
    });
  });

  group('canCompleteToday', () {
    test('returns false when there is already a completion today', () {
      final now = DateTime.now();
      final completions = [
        buildCompletion(
          completedAt: now.subtract(const Duration(hours: 1)),
        ),
      ];

      final result = service.canCompleteToday('habit-1', completions);
      expect(result, isFalse);
    });

    test('returns true when no completions exist for today', () {
      final completions = [
        buildCompletion(
          completedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

      final result = service.canCompleteToday('habit-1', completions);
      expect(result, isTrue);
    });
  });
}

