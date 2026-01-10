import 'package:exohabit/habits/habit_local_store.dart';
import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/sync/sync_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'override_sync_service.g.dart';

@riverpod
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
          await ref.read(overrideSyncServiceProvider).sync(userId);
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
SyncService overrideSyncService(Ref ref) => OverrideSyncService(
  localStore: ref.watch(habitLocalStoreProvider),
  remoteStore: ref.watch(habitRemoteStoreProvider),
);

/// Overrides local db with remote (only `deleted = false`)
class OverrideSyncService implements SyncService {
  OverrideSyncService({
    required HabitLocalStore localStore,
    required HabitRemoteStore remoteStore,
  }) : _local = localStore,
       _remote = remoteStore;

  final HabitLocalStore _local;
  final HabitRemoteStore _remote;

  @override
  Future<void> sync(String userId) => _local.transaction(() async {
    await _local.clear();
    final remoteHabits = await _remote.fetchNotDeleted(userId);
    for (final habit in remoteHabits) {
      await _local.upsert(habit);
    }
  });
}
