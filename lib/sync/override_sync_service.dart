import 'package:exohabit/completions/completion_local_store.dart';
import 'package:exohabit/completions/completion_remote_store.dart';
import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/habits/habit_local_store.dart';
import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/logger.dart';
import 'package:exohabit/rewards/reward_local_store.dart';
import 'package:exohabit/rewards/reward_remote_store.dart';
import 'package:exohabit/rewards/rewards_table.dart';
import 'package:exohabit/sync/sync_service.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'override_sync_service.g.dart';

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

@riverpod
OverrideSyncService<Reward> rewardOverrideSyncService(Ref ref) =>
    OverrideSyncService(
      localStore: ref.watch(rewardLocalStoreProvider),
      remoteStore: ref.watch(rewardRemoteStoreProvider),
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
  Future<void> sync(String userId) async {
    await _local.clear();
    final remotes = await _remote.fetchNotDeleted(userId);
    for (final e in remotes) {
      await _local.upsert(e, synced: true);
    }
  }
}

@Riverpod(keepAlive: true)
OverrideSyncCoordinator overrideSyncCoordinator(Ref ref) =>
    OverrideSyncCoordinator(
      habitSyncService: ref.watch(habitOverrideSyncServiceProvider),
      completionSyncService: ref.watch(completionOverrideSyncServiceProvider),
      rewardSyncService: ref.watch(rewardOverrideSyncServiceProvider),
    );

class OverrideSyncCoordinator {
  OverrideSyncCoordinator({
    required OverrideSyncService<Habit> habitSyncService,
    required OverrideSyncService<Completion> completionSyncService,
    required OverrideSyncService<Reward> rewardSyncService,
  }) : _habitSyncService = habitSyncService,
       _completionSyncService = completionSyncService,
       _rewardSyncService = rewardSyncService;

  final OverrideSyncService<Habit> _habitSyncService;
  final OverrideSyncService<Completion> _completionSyncService;
  final OverrideSyncService<Reward> _rewardSyncService;
  bool isSyncing = false;

  Future<void> sync(String? userId) async {
    if (userId == null || isSyncing) {
      return;
    }

    logger.i('Syncing with remote (override)...');
    isSyncing = true;
    try {
      await _habitSyncService.sync(userId);
      await _completionSyncService.sync(userId);
      await _rewardSyncService.sync(userId);
    } finally {
      isSyncing = false;
    }
    logger.i('Syncing with remote (override) finished');
  }
}
