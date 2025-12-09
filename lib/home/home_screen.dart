import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/exoplanets/exoplanets_screen.dart';
import 'package:exohabit/home/widgets/weekly_calendar.dart';
import 'package:exohabit/models/exoplanet.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/providers/completion_providers.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:exohabit/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final authState = ref.watch(authStateProvider);
    final email = authState.value?.email ?? 'Explorer';

    final statsAsync = ref.watch(homeStatsProvider);
    final habitsAsync = ref.watch(habitsProvider);
    final exoplanetsAsync = ref.watch(exoplanetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exohabit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authRepo.signOut();
            },
          )
        ],
      ),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (stats) {
          return RefreshIndicator(
            onRefresh: () async {
              // Invalidate providers to trigger refresh
              ref.invalidate(homeStatsProvider);
              ref.invalidate(habitsProvider);
              ref.invalidate(exoplanetsProvider);

              // Wait for providers to actually refresh their data
              await Future.wait([
                ref.read(habitsProvider.future),
                ref.read(exoplanetsProvider.future),
              ]);
              // Note: homeStatsProvider will automatically refresh when its dependencies refresh
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _GreetingCard(email: email, streak: stats.streakDays),
                  const SizedBox(height: 12),
                  _WeeklyProgressCard(stats: stats),
                  const SizedBox(height: 12),
                  _CalendarSection(stats: stats),
                  const SizedBox(height: 12),
                  _ExoplanetHighlight(exoplanetsAsync: exoplanetsAsync),
                  const SizedBox(height: 16),
                  _TodayHabitsList(habitsAsync: habitsAsync),
                  const SizedBox(height: 16),
                  _QuickActions(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GreetingCard extends StatelessWidget {
  const _GreetingCard({required this.email, required this.streak});

  final String email;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade400,
            Colors.deepPurple.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      '$streak day streak',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.rocket_launch, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}

class _WeeklyProgressCard extends StatelessWidget {
  const _WeeklyProgressCard({required this.stats});

  final HomeStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'This week',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text('${stats.weekCount}/${stats.weekGoal}'),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: stats.weeklyProgress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _StatPill(
                  label: 'Today',
                  value: '${stats.todayCount}',
                  icon: Icons.check_circle,
                ),
                const SizedBox(width: 8),
                _StatPill(
                  label: 'Habits',
                  value: '${stats.habitsCount}',
                  icon: Icons.list_alt,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarSection extends StatelessWidget {
  const _CalendarSection({required this.stats});

  final HomeStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly glance',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            WeeklyCalendarStrip(weekdayCounts: stats.weekdayCounts),
          ],
        ),
      ),
    );
  }
}

class _ExoplanetHighlight extends StatelessWidget {
  const _ExoplanetHighlight({required this.exoplanetsAsync});

  final AsyncValue<List<Exoplanet>> exoplanetsAsync;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: exoplanetsAsync.when(
          loading: () => const SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text('Error loading exoplanets: $e'),
          data: (list) {
            final latest = list.isNotEmpty ? list.first : null;
            return Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade300,
                        Colors.indigo.shade400,
                      ],
                    ),
                  ),
                  child: const Icon(Icons.public, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent discovery',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        latest != null ? latest.name : 'No planets yet',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text('${list.length} unlocked'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => context.push('/exoplanets'),
                  child: const Text('View'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TodayHabitsList extends ConsumerWidget {
  const _TodayHabitsList({required this.habitsAsync});

  final AsyncValue<List<Habit>> habitsAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return habitsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
      data: (habits) {
        if (habits.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Today's habits",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text('No habits yet. Create one to get started!'),
                ],
              ),
            ),
          );
        }

        final todayHabits = habits.take(3).toList();

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Today's habits",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () => context.push('/habits'),
                      child: const Text('View all'),
                    ),
                  ],
                ),
                ...todayHabits.map((h) => _HabitQuickTile(habit: h)).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HabitQuickTile extends ConsumerStatefulWidget {
  const _HabitQuickTile({required this.habit});

  final Habit habit;

  @override
  ConsumerState<_HabitQuickTile> createState() => _HabitQuickTileState();
}

class _HabitQuickTileState extends ConsumerState<_HabitQuickTile> {
  bool _isCompleting = false;

  Future<void> _complete() async {
    if (_isCompleting) return;

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final canComplete = ref.read(canCompleteTodayProvider(widget.habit.id));
    if (!canComplete) return;

    setState(() => _isCompleting = true);
    try {
      final repo = ref.read(habitRepositoryProvider);
      final completionId = await repo.recordCompletion(
        widget.habit.id,
        userId,
        DateTime.now(),
      );

      final rewardService = ref.read(rewardServiceProvider);
      await rewardService.awardExoplanet(widget.habit.id, userId, completionId);
    } finally {
      if (mounted) setState(() => _isCompleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canComplete = ref.watch(canCompleteTodayProvider(widget.habit.id));

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.habit.title),
      subtitle: Text('Goal: ${widget.habit.frequencyPerWeek} / week'),
      trailing: _isCompleting
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : IconButton(
              icon: Icon(
                canComplete ? Icons.check_circle_outline : Icons.check_circle,
                color: canComplete ? Colors.grey : Colors.green,
              ),
              tooltip: canComplete ? 'Mark complete' : 'Already completed today',
              onPressed: canComplete ? _complete : null,
            ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.push('/create-habit'),
            icon: const Icon(Icons.add),
            label: const Text('Add habit'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.push('/exoplanets'),
            icon: const Icon(Icons.public),
            label: const Text('Exoplanets'),
          ),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.deepPurple),
          const SizedBox(width: 6),
          Text(
            '$value $label',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
