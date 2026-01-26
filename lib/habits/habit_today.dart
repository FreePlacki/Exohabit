import 'package:exohabit/completions/completion_repository.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/rewards/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HabitTodayCard extends ConsumerWidget {
  const HabitTodayCard({
    super.key,
    required this.habit,
    required this.onReward,
  });

  final HabitToday habit;
  final void Function(Exoplanet) onReward;

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
            onReward(exoplanet);
          }
        },
        onLongPress: () => context.push('/edit-habit/${habit.habit.id}'),
        child: Padding(
          padding: const .all(16),
          child: Row(
            children: [
              _CompletionIndicator(
                completed: habit.completedToday,
                category: habit.habit.row.category,
              ),
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
  const _CompletionIndicator({required this.completed, required this.category});

  final bool completed;
  final HabitCategory category;

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
              : category.color,
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
    final scheme = Theme.of(context).colorScheme;

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
        const SizedBox(height: 4),
        TweenAnimationBuilder(
          tween: Tween(
            begin: 0.toDouble(),
            end:
                habit.weeklyProgress.toDouble() /
                habit.habit.row.frequencyPerWeek.toDouble(),
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              minHeight: 4,
              color: habit.weeklyGoalMet ? Colors.green : scheme.primary,
              backgroundColor: scheme.onSurface.withValues(alpha: 0.2),
              borderRadius: const .all(.circular(12)),
            );
          },
        ),
      ],
    );
  }
}

class TodayOverviewCard extends StatelessWidget {
  const TodayOverviewCard({
    super.key,
    required this.completed,
    required this.total,
  });

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = total == 0 ? 0.0 : completed / total;

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _ProgressRing(progress: progress),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Today', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    '$completed of $total habits completed',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _statusText(completed, total),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _statusColor(theme, completed, total),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _statusText(int completed, int total) {
    if (total == 0) {
      return 'No habits scheduled';
    }
    if (completed == total) {
      return 'All missions completed';
    }
    if (completed == 0) {
      return 'Mission not started';
    }
    return 'In progress';
  }

  static Color _statusColor(ThemeData theme, int completed, int total) {
    if (completed == total && total > 0) {
      return Colors.green;
    }
    return theme.colorScheme.onSurfaceVariant;
  }
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: .center,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: progress),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return SizedBox(
              width: 56,
              height: 56,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 6,
                backgroundColor: theme.colorScheme.onSurface.withValues(
                  alpha: 0.1,
                ),
              ),
            );
          },
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '${(progress * 100).round()}%',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
