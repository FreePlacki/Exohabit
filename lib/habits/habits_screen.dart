import 'package:exohabit/completions/completion_repository.dart';
import 'package:exohabit/habits/habit_controller.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final class HabitWeekly {
  HabitWeekly({required this.habit, required this.completedDays});

  final Habit habit;

  final List<bool> completedDays;
  int get completedCount => completedDays.where((e) => e).length;
  bool get weeklyGoalMet => completedCount >= habit.row.frequencyPerWeek;
}

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final user = ref.watch(currentUserProvider);
    final userEmail = user?.email ?? 'Signed out';
    final habits = ref.watch(weeklyHabitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Habits - $userEmail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authRepo.signOut();
              if (context.mounted) {
                context.go('/auth');
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/create-habit');
        },
        child: const Icon(Icons.add),
      ),
      body: habits.when(
        skipLoadingOnReload: true,
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('No habits yet...'));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final h = list[i];
              return HabitSummaryCard(
                habit: h,
                onEdit: () => context.push('/edit-habit/${h.habit.id}'),
                onDelete: () => _showDeleteDialog(context, ref, h.habit),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

void _showDeleteDialog(BuildContext context, WidgetRef ref, Habit habit) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Habit'),
      content: Text('Are you sure you want to delete "${habit.row.title}"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            final controller = ref.read(habitControllerProvider.notifier);
            final state = ref.watch(habitControllerProvider);

            await controller.delete(habit);

            if (context.mounted && state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error deleting habit: ${state.error}')),
              );
            }
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

class HabitSummaryCard extends StatelessWidget {
  const HabitSummaryCard({
    super.key,
    required this.habit,
    required this.onEdit,
    required this.onDelete,
  });

  final HabitWeekly habit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.habit.row.title,
                        style: theme.textTheme.titleMedium,
                      ),
                      if (habit.habit.row.description.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          habit.habit.row.description,
                          style: theme.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete',
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Completion strip
            _CompletionStrip(completedDays: habit.completedDays),

            const SizedBox(height: 8),

            // Weekly summary
            Text(
              '${habit.completedCount} / ${habit.habit.row.frequencyPerWeek} this week'
              '${habit.weeklyGoalMet ? ' · goal met' : ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: habit.weeklyGoalMet
                    ? Colors.green
                    : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletionStrip extends StatelessWidget {
  const _CompletionStrip({required this.completedDays});

  /// Oldest -> newest (length = 7)
  final List<bool> completedDays;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: List.generate(completedDays.length, (i) {
        final completed = completedDays[i];
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: completed
                    ? scheme.primary
                    : scheme.onSurface.withValues(alpha: 0.15),
              ),
            ),
          ),
        );
      }),
    );
  }
}
