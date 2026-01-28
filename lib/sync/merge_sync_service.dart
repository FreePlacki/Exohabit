import 'package:exohabit/completions/completion_local_store.dart';
import 'package:exohabit/completions/completion_remote_store.dart';
import 'package:exohabit/habits/habit_local_store.dart';
import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:exohabit/logger.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/rewards/reward_local_store.dart';
import 'package:exohabit/rewards/reward_remote_store.dart';
import 'package:exohabit/sync/sync_service.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merge_sync_service.g.dart';

@riverpod
SyncService habitMergeSyncService(Ref ref) => MergeSyncService(
  localStore: ref.watch(habitLocalStoreProvider),
  remoteStore: ref.watch(habitRemoteStoreProvider),
);

@riverpod
SyncService completionMergeSyncService(Ref ref) => MergeSyncService(
  localStore: ref.watch(completionLocalStoreProvider),
  remoteStore: ref.watch(completionRemoteStoreProvider),
);

@riverpod
SyncService rewardMergeSyncService(Ref ref) => MergeSyncService(
  localStore: ref.watch(rewardLocalStoreProvider),
  remoteStore: ref.watch(rewardRemoteStoreProvider),
);

void _listenForUnsynced<T>(
  Ref ref, {
  required ProviderListenable<AsyncValue<List<T>>> provider,
  required bool Function(T) isUnsynced,
  required String reason,
}) {
  ref.listen<bool>(
    provider.select((async) {
      final list = async.value;
      return list != null && list.any(isUnsynced);
    }),
    (prev, next) async {
      if (prev == false && next == true) {
        logger.i('Sync triggered by $reason');
        try {
          await ref
              .read(mergeSyncCoordinatorProvider)
              .delayedSync(ref.read(currentUserIdProvider));
        } catch (e, st) {
          logger.e("Couldn't sync with remote", error: e, stackTrace: st);
        }
      }
    },
  );
}

@Riverpod(keepAlive: true)
void syncListener(Ref ref) {
  _listenForUnsynced(
    ref,
    provider: unsyncedHabitsProvider,
    isUnsynced: (e) => !e.row.synced,
    reason: 'unsynced Habits',
  );

  _listenForUnsynced(
    ref,
    provider: unsyncedCompletionsProvider,
    isUnsynced: (e) => !e.row.synced,
    reason: 'unsynced Completions',
  );
}

/// Merges the remote with local database
/// 1) pull all data from remote
/// 2) if H in remote and not in local and `deleted = false`, insert to local
/// 3) if H not in remote and in local, insert to remote
///     NOTE: we also insert if `deleted = false` to notify others of deletion
/// 4) otherwise compare `updatedAt` and override older
class MergeSyncService<T extends SyncEntity> implements SyncService {
  MergeSyncService({
    required LocalSyncStore<T> localStore,
    required RemoteSyncStore<T> remoteStore,
  }) : _local = localStore,
       _remote = remoteStore;

  final LocalSyncStore<T> _local;
  final RemoteSyncStore<T> _remote;

  @override
  Future<void> sync(String userId) async {
    final localUnsynced = await _local.unsynced();
    final localAll = await _local.fetchAll();
    final remoteAll = await _remote.fetchAll(userId);

    final localById = {for (final e in localAll) e.id: e};
    final remoteById = {for (final e in remoteAll) e.id: e};

    // Local -> Remote
    for (final local in localUnsynced) {
      final remote = remoteById[local.id];

      final updateRemote =
          remote == null || remote.updatedAt.isBefore(local.updatedAt);

      if (updateRemote) {
        await _remote.upsert(local, userId);
      }

      await _local.markSynced(local.id);
    }

    // Remote -> Local
    for (final remote in remoteAll) {
      final local = localById[remote.id];

      final updateLocal =
          (local == null && !remote.deleted) ||
          (local != null && local.updatedAt.isBefore(remote.updatedAt));

      if (updateLocal) {
        await _local.upsert(remote, synced: true);
      }
    }
  }
}

@Riverpod(keepAlive: true)
MergeSyncCoordinator mergeSyncCoordinator(Ref ref) => MergeSyncCoordinator(
  habitSyncService: ref.watch(habitMergeSyncServiceProvider),
  completionSyncService: ref.watch(completionMergeSyncServiceProvider),
  rewardSyncService: ref.watch(rewardMergeSyncServiceProvider),
);

class MergeSyncCoordinator {
  MergeSyncCoordinator({
    required SyncService habitSyncService,
    required SyncService completionSyncService,
    required SyncService rewardSyncService,
  }) : _habitSyncService = habitSyncService,
       _completionSyncService = completionSyncService,
       _rewardSyncService = rewardSyncService;

  final SyncService _habitSyncService;
  final SyncService _completionSyncService;
  final SyncService _rewardSyncService;
  bool isSyncing = false;
  bool scheduledSync = false;

  Future<void> sync(String? userId) async {
    if (userId == null || isSyncing) {
      return;
    }

    logger.i('Syncing with remote (merge)...');
    isSyncing = true;
    try {
      await _habitSyncService.sync(userId);
      await _completionSyncService.sync(userId);
      await _rewardSyncService.sync(userId);
    } finally {
      isSyncing = false;
    }
    logger.i('Syncing with remote (merge) finished');
  }

  Future<void> delayedSync(
    String? userId, {
    Duration duration = const Duration(seconds: 1),
  }) async {
    if (isSyncing || scheduledSync) {
      return;
    }

    scheduledSync = true;
    try {
      await Future.delayed(duration, () {});
      await sync(userId);
    } finally {
      scheduledSync = false;
    }
  }
}
