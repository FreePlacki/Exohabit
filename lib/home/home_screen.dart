import 'package:exohabit/habits/habit_controller.dart';
import 'package:exohabit/home/home_controller.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/sync/merge_sync_service.dart';
import 'package:exohabit/sync/override_sync_service.dart';
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

  Future<void> _showSyncDialog() async {
    final result = await showDialog<_SyncChoice>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _SyncDecisionDialog(),
    );
    _syncDialogShown = false;

    final userId = ref.read(currentUserIdProvider);
    if (!mounted || userId == null || result == null) {
      return;
    }

    switch (result) {
      case .merge:
        await ref.read(mergeSyncServiceProvider).sync(userId);
      case .override:
        await ref.read(overrideSyncServiceProvider).sync(userId);
    }

    ref.read(pendingSyncDecisionProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    final authRepo = ref.read(authRepositoryProvider);
    final user = ref.watch(currentUserProvider);

    final habits = ref.watch(habitsProvider);
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
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
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

              ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text('Statistics'),
                enabled: false,
                onTap: () {},
              ),

              const Divider(),

              ListTile(
                enabled: user != null,
                leading: const Icon(Icons.sync),
                title: const Text('Sync now'),
                trailing: switch (syncState) {
                  MutationPending() => const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  _ => null,
                },
                onTap: syncState is MutationPending
                    ? null
                    : () async {
                        Navigator.pop(context);
                        await ref.read(homeControllerProvider.notifier).sync();
                      },
              ),

              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                enabled: false, // future
                onTap: () {},
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
      ),
      body: habits.when(
        data: (data) => RefreshIndicator(
          onRefresh: ref.read(homeControllerProvider.notifier).sync,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (buildContext, i) {
              final habit = data[i];
              return Text(habit.title);
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
}

enum _SyncChoice { merge, override }

class _SyncDecisionDialog extends StatelessWidget {
  const _SyncDecisionDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sync habits'),
      content: const Text(
        'You already have habits stored on this device.\n\n'
        'How do you want to sync them with your account?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _SyncChoice.override),
          child: const Text('Replace local data'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _SyncChoice.merge),
          child: const Text('Merge'),
        ),
      ],
    );
  }
}
