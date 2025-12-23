
import 'package:exohabit/habits/habit_extensions.dart';
import 'package:exohabit/habits/habit_local_store.dart';
import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:exohabit/sync/sync_service.dart';
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
class MergeSyncService implements SyncService {
  MergeSyncService({
    required HabitLocalStore localStore,
    required HabitRemoteStore remoteStore,
  }) : _local = localStore,
       _remote = remoteStore;

  final HabitLocalStore _local;
  final HabitRemoteStore _remote;

  @override
  Future<void> sync(String userId) => _local.transaction(() async {
    final localHabits = await _local.unsynced();

    // TODO: avoid n network calls
    for (final habit in localHabits) {
      final remoteHabit = await _remote.fetchById(habit.id);
      final updateRemote =
          remoteHabit == null ||
          HabitExtensions.fromRemote(
            remoteHabit,
            synced: true,
          ).updatedAt.isBefore(habit.updatedAt);
      if (updateRemote) {
        await _remote.upsert(habit, userId);
      }

      await _local.markSynced(habit.id);
    }

    final remoteHabits = (await _remote.fetch(
      userId,
    )).map((h) => HabitExtensions.fromRemote(h, synced: true));
    // print('remote: $remoteHabits');
    // print('local: ${await _local.watch().first}');
    for (final habit in remoteHabits) {
      final localHabit = await _local.fetchById(habit.id);
      final updateLocal =
          (localHabit == null && !habit.deleted) ||
          (localHabit != null &&
              localHabit.updatedAt.isBefore(habit.updatedAt));
      if (updateLocal) {
        await _local.upsert(habit);
      }

      await _local.markSynced(habit.id);
    }
  });
}
