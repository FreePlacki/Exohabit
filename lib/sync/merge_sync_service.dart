import 'package:exohabit/habits/habit_local_store.dart';
import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:exohabit/sync/sync_service.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merge_sync_service.g.dart';

@riverpod
SyncService mergeSyncService(Ref ref) => MergeSyncService(
  localStore: ref.watch(habitLocalStoreProvider),
  remoteStore: ref.watch(habitRemoteStoreProvider),
);

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

    // Local → Remote
    for (final local in localUnsynced) {
      final remote = remoteById[local.id];

      final updateRemote =
          remote == null || remote.updatedAt.isBefore(local.updatedAt);

      if (updateRemote) {
        await _remote.upsert(local, userId);
      }

      await _local.markSynced(local.id);
    }

    // Remote → Local
    for (final remote in remoteAll) {
      final local = localById[remote.id];

      final updateLocal =
          (local == null && !remote.deleted) ||
          (local != null && local.updatedAt.isBefore(remote.updatedAt));

      if (updateLocal) {
        await _local.upsert(remote);
      }

      await _local.markSynced(remote.id);
    }
  }
}
