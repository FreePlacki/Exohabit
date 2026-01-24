import 'package:exohabit/completions/completion_repository.dart';
import 'package:exohabit/completions/habit_today.dart';
import 'package:exohabit/habits/habit_controller.dart';
import 'package:exohabit/home/home_controller.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/sync/merge_sync_service.dart';
import 'package:exohabit/sync/override_sync_service.dart';
import 'package:exohabit/sync/sync_decision_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var _syncDialogShown = false;

  @override
  void initState() {
    super.initState();

    ref.listenManual(pendingSyncDecisionProvider, (prev, next) {
      if (next != null && !_syncDialogShown) {
        _syncDialogShown = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showSyncDialog();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authRepo = ref.read(authRepositoryProvider);

    final habits = ref.watch(todayHabitsProvider);
    final state = ref.watch(homeControllerProvider);
    final syncState = ref.watch(syncMutation);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
          switch (syncState) {
            MutationPending() => const CircularProgressIndicator(),
            _ => IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: ref.read(homeControllerProvider.notifier).sync,
            ),
          },
        ],
      ),
      drawer: const _Drawer(),
      body: habits.when(
        skipLoadingOnReload: true,
        data: (data) => RefreshIndicator(
          onRefresh: ref.read(homeControllerProvider.notifier).sync,
          child: data.isEmpty ?
            const Center(child: Text('No habits yet...'))
          : ListView.separated(
            padding: const .all(16),
            itemCount: data.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (buildContext, i) {
              final habit = data[i];
              return HabitTodayCard(habit: habit);
            },
          ),
        ),
        error: (err, st) => Center(child: Text('Error loading habits ($err)')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          context.push('/habits');
        },
      ),
    );
  }

  Future<void> _showSyncDialog() async {
    final result = await showDialog<SyncChoice>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SyncDecisionDialog(),
    );
    _syncDialogShown = false;

    final userId = ref.read(currentUserIdProvider);
    if (!mounted || userId == null || result == null) {
      return;
    }

    switch (result) {
      case .merge:
        try {
          await ref.read(mergeSyncCoordinatorProvider).sync();
        } on Exception catch (_) {
          await ref.read(overrideSyncCoordinatorProvider).sync();
        }
      case .override:
        await ref.read(overrideSyncCoordinatorProvider).sync();
    }

    ref.read(pendingSyncDecisionProvider.notifier).clear();
  }
}

class _Drawer extends ConsumerWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final user = ref.watch(currentUserProvider);
    final habits = ref.watch(habitsProvider);
    final syncState = ref.watch(syncMutation);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.account_circle, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    user?.email ?? 'Anonymous',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Habits: ${habits.value?.length ?? 0}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Habits'),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),

            const Divider(),

            ListTile(
              enabled: user != null && syncState is! MutationPending,
              leading: const Icon(Icons.sync),
              title: const Text('Sync now'),
              trailing: syncState is MutationPending
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
              onTap: () async {
                Navigator.pop(context);
                await ref.read(homeControllerProvider.notifier).sync();
              },
            ),

            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Exoplanets'),
              onTap: () async {
                Navigator.pop(context);
                await context.push('/exoplanets');
              },
            ),

            const Spacer(),
            const Divider(),

            if (user == null)
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login'),
                onTap: () => context.go('/auth'),
              )
            else
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  Navigator.pop(context);
                  await authRepo.signOut();
                  if (context.mounted) {
                    context.go('/auth');
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
