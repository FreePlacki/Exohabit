import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/habit_providers.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final habits = ref.watch(habitsProvider);
    final authState = ref.watch(authStateProvider);
    final userEmail = authState.value!.email;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Habits - $userEmail"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authRepo.signOut();
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
            return const Center(child: Text("No habits yet."));
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
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}

void _showDeleteDialog(BuildContext context, WidgetRef ref, Habit habit) {
  showDialog(
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
            final userId = ref.read(currentUserIdProvider);
            if (userId == null) return;
            
            try {
              final repo = ref.read(habitRepositoryProvider);
              await repo.deleteHabit(habit.id, userId);
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting habit: $e')),
                );
              }
            }
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

class _HabitListItem extends StatelessWidget {
  final Habit habit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _HabitListItem({
    required this.habit,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habit.title),
      subtitle: Text(habit.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${habit.frequencyPerWeek}x / week"),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
            tooltip: 'Edit habit',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
            tooltip: 'Delete habit',
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
