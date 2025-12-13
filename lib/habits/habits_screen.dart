import 'dart:async';

import 'package:exohabit/exoplanets/exoplanets_screen.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/providers/completion_providers.dart';
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
    final userEmail = authState.value?.email ?? 'Signed out';
    final exoplanets = ref.watch(exoplanetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Habits - $userEmail"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.rocket_launch),
                onPressed: () {
                  context.push('/exoplanets');
                },
                tooltip: 'View Exoplanets',
              ),
              exoplanets.when(
                data: (list) {
                  if (list.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${list.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ],
          ),
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
            if (userId == null) {
              return;
            }

            try {
              final repo = ref.read(habitRepositoryProvider);
              await repo.deleteHabit(habit.id, userId);
            } catch (err) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting habit: $err')),
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

class _HabitListItem extends ConsumerStatefulWidget {
  final Habit habit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _HabitListItem({
    required this.habit,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  ConsumerState<_HabitListItem> createState() => _HabitListItemState();
}

class _HabitListItemState extends ConsumerState<_HabitListItem> {
  bool _isCompleting = false;

  Future<void> _handleCompletion() async {
    if (_isCompleting) return;

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final canComplete = ref.read(canCompleteTodayProvider(widget.habit.id));
    if (!canComplete) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Already completed today!')),
        );
      }
      return;
    }

    setState(() {
      _isCompleting = true;
    });

    try {
      await Future.any([
        _performCompletion(userId),
        Future.delayed(
          const Duration(seconds: 15),
          () => throw TimeoutException('Completion timed out'),
        ),
      ]);

      if (mounted) {
        // Show success with option to view exoplanets
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Exoplanet discovered!'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.white,
              onPressed: () {
                context.push('/exoplanets');
              },
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final errorMessage =
            e.toString().contains('Connection') || e is TimeoutException
            ? 'Connection issue. Check your internet and try again.'
            : 'Error completing habit';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCompleting = false;
        });
      }
    }
  }

  Future<void> _performCompletion(String userId) async {
    final habitRepo = ref.read(habitRepositoryProvider);
    print('📝 Recording completion...');
    final completionId = await habitRepo.recordCompletion(
      widget.habit.id,
      userId,
      DateTime.now(),
    );
    print('✅ Completion recorded: $completionId');

    // Award exoplanet
    print('🎁 Awarding exoplanet...');
    final rewardService = ref.read(rewardServiceProvider);
    await rewardService.awardExoplanet(widget.habit.id, userId, completionId);
    print('🎉 Exoplanet awarded successfully');
  }

  @override
  Widget build(BuildContext context) {
    final weeklyProgress = ref.watch(weeklyProgressProvider(widget.habit.id));
    final canComplete = ref.watch(canCompleteTodayProvider(widget.habit.id));
    final progressPercent = widget.habit.frequencyPerWeek > 0
        ? (weeklyProgress / widget.habit.frequencyPerWeek).clamp(0.0, 1.0)
        : 0.0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(widget.habit.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.habit.description),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progressPercent,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progressPercent >= 1.0 ? Colors.green : Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$weeklyProgress / ${widget.habit.frequencyPerWeek}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Completion button
            _isCompleting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    icon: Icon(
                      canComplete
                          ? Icons.check_circle_outline
                          : Icons.check_circle,
                      color: canComplete ? Colors.grey : Colors.green,
                    ),
                    onPressed: canComplete && !_isCompleting
                        ? _handleCompletion
                        : null,
                    tooltip: canComplete
                        ? 'Mark complete'
                        : 'Already completed today',
                  ),
            const SizedBox(width: 8),
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
