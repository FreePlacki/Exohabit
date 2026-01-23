import 'package:exohabit/completions/completion_repository.dart';
import 'package:exohabit/rewards/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitTodayCard extends ConsumerWidget {
  const HabitTodayCard({super.key, required this.habit});

  final HabitToday habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionRepo = ref.read(completionRepositoryProvider);
    final rewardRepo = ref.read(rewardRepositoryProvider);

    return Material(
      borderRadius: .circular(16),
      color: Theme.of(context).colorScheme.surface,
      elevation: 1,
      child: InkWell(
        borderRadius: .circular(16),
        onTap: () async {
          await rewardRepo.awardRandom();
          return completionRepo.complete(habit.habit.id, DateTime.now());
        },
        child: Padding(
          padding: const .all(16),
          child: Row(
            children: [
              _CompletionIndicator(completed: habit.completedToday),
              const SizedBox(width: 16),
              Expanded(child: _HabitText(habit: habit)),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletionIndicator extends StatelessWidget {
  const _CompletionIndicator({required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: .circle,
        color: completed
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        border: .all(
          color: completed
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
          width: 2,
        ),
      ),
      child: completed ? const Icon(Icons.check, color: Colors.white) : null,
    );
  }
}

class _HabitText extends ConsumerWidget {
  const _HabitText({required this.habit});

  final HabitToday habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(habit.habit.row.title, style: style.titleMedium),
        const SizedBox(height: 4),
        Text(
          '${habit.weeklyProgress} / ${habit.habit.row.frequencyPerWeek} this week'
          '${habit.weeklyGoalMet ? ' · goal met' : ''}',
          style: style.bodySmall?.copyWith(
            color: habit.weeklyGoalMet ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}
