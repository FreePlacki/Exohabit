import 'package:exohabit/completions/completion_repository.dart';
import 'package:exohabit/rewards/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HabitTodayCard extends ConsumerWidget {
  const HabitTodayCard({super.key, required this.habit});

  final HabitToday habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionRepo = ref.read(completionRepositoryProvider);
    final rewardRepo = ref.read(rewardRepositoryProvider);

    return Material(
      borderRadius: .circular(16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      elevation: 1,
      child: InkWell(
        borderRadius: .circular(16),
        onTap: () async {
          final newCompletion = await completionRepo.complete(
            habit.habit.id,
            DateTime.now(),
          );
          if (newCompletion) {
            final exoplanet = await rewardRepo.awardRandom();
            if (!context.mounted) {
              return;
            }
            _showAutoHideBanner(
              context,
              'New exoplanet discovered!',
              () => context.push('/exoplanet-details', extra: exoplanet),
              'Show',
            );
          }
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

  void _showAutoHideBanner(
    BuildContext context,
    String message,
    void Function() action,
    String actionText,
  ) {
    final messenger = ScaffoldMessenger.of(context)..clearMaterialBanners();
    messenger.showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              messenger.clearMaterialBanners();
              action();
            },
            child: Text(actionText),
          ),
        ],
      ),
    );
    // Auto-hide after 2 seconds
    Future.delayed(const Duration(seconds: 10), messenger.clearMaterialBanners);
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
