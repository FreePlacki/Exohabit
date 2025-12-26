import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habit_controller.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final habits = ref.watch(habitsProvider);
    final user = ref.watch(currentUserProvider);
    final userEmail = user?.email ?? 'Signed out';

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
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('No habits yet.'));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final h = list[i];
              return _HabitListItem(
                habit: h,
                onEdit: () => context.push('/edit-habit', extra: h),
                onDelete: () => _showDeleteDialog(context, ref, h),
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
      content: Text('Are you sure you want to delete "${habit.title}"?'),
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

class _HabitListItem extends ConsumerStatefulWidget {
  const _HabitListItem({
    required this.habit,
    required this.onEdit,
    required this.onDelete,
  });
  final Habit habit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  ConsumerState<_HabitListItem> createState() => _HabitListItemState();
}

class _HabitListItemState extends ConsumerState<_HabitListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(widget.habit.title),
        subtitle: Text(widget.habit.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Completion button
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: widget.onEdit,
              tooltip: 'Edit habit',
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: widget.onDelete,
              tooltip: 'Delete habit',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
