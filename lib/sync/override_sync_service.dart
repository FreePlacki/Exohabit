import 'package:exohabit/completions/completion_local_store.dart';
import 'package:exohabit/completions/completion_remote_store.dart';
import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/habits/habit_local_store.dart';
import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/sync/sync_service.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'override_sync_service.g.dart';

@Riverpod(keepAlive: true)
void authSyncListener(Ref ref) {
  var initialized = false;

  ref.listen(authStateProvider, (prev, next) async {
    if (next.isLoading || next.hasError) {
      return;
    }

    if (!initialized) {
      initialized = true;
      return;
    }

    final prevSession = prev?.value?.session;
    final nextSession = next.value?.session;

    // logout
    if (prevSession != null && nextSession == null) {
      // no clear for now
      return;
    }

    if (nextSession != null) {
      final userId = nextSession.user.id;
      final prevUserId = prevSession?.user.id;
      // account switch
      if (userId != prevUserId) {
        final hasData = await ref.read(habitLocalStoreProvider).hasAny();
        if (hasData) {
          ref.read(pendingSyncDecisionProvider.notifier).init();
        } else {
          await ref.read(overrideSyncCoordinatorProvider).sync();
        }
      }
    }
  });
}

class PendingSyncDecision {}

@riverpod
class PendingSyncDecisionNotifier extends _$PendingSyncDecisionNotifier {
  @override
  PendingSyncDecision? build() => null;

  void init() => state = PendingSyncDecision();
  void clear() => state = null;
}

@riverpod
OverrideSyncService<Habit> habitOverrideSyncService(Ref ref) =>
    OverrideSyncService(
      localStore: ref.watch(habitLocalStoreProvider),
      remoteStore: ref.watch(habitRemoteStoreProvider),
    );

@riverpod
OverrideSyncService<Completion> completionOverrideSyncService(Ref ref) =>
    OverrideSyncService(
      localStore: ref.watch(completionLocalStoreProvider),
      remoteStore: ref.watch(completionRemoteStoreProvider),
    );

/// Overrides local db with remote (only `deleted = false`)
class OverrideSyncService<T extends SyncEntity> implements SyncService {
  OverrideSyncService({
    required LocalSyncStore<T> localStore,
    required RemoteSyncStore<T> remoteStore,
  }) : _local = localStore,
       _remote = remoteStore;

  final LocalSyncStore<T> _local;
  final RemoteSyncStore<T> _remote;

  @override
  Future<void> sync(String userId) => _local.transaction(() async {
    await _local.clear();
    final remoteHabits = await _remote.fetchNotDeleted(userId);
    for (final habit in remoteHabits) {
      await _local.upsert(habit);
    }
  });
}

@riverpod
OverrideSyncCoordinator overrideSyncCoordinator(Ref ref) =>
    OverrideSyncCoordinator(
      userId: ref.watch(currentUserIdProvider),
      habitSyncService: ref.watch(habitOverrideSyncServiceProvider),
      completionSyncService: ref.watch(completionOverrideSyncServiceProvider),
    );

class OverrideSyncCoordinator {
  OverrideSyncCoordinator({
    required String? userId,
    required OverrideSyncService<Habit> habitSyncService,
    required OverrideSyncService<Completion> completionSyncService,
  }) : _userId = userId,
       _habitSyncService = habitSyncService,
       _completionSyncService = completionSyncService;

  final String? _userId;
  final OverrideSyncService<Habit> _habitSyncService;
  final OverrideSyncService<Completion> _completionSyncService;

  Future<void> sync() async {
    if (_userId == null) {
      return;
    }

    await _habitSyncService.sync(_userId);
    await _completionSyncService.sync(_userId);
  }
}
