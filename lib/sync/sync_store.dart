import 'package:exohabit/sync/sync_service.dart';

abstract class LocalSyncStore<T extends SyncEntity> {
  Future<List<T>> unsynced();
  Future<List<T>> fetchAll();
  Future<T?> fetchById(String id);
  Future<void> upsert(T entity, {bool synced = false});
  Future<void> markSynced(String id);
  Future<void> clear();
  Future<void> transaction(Future<void> Function() action);
}

abstract class RemoteSyncStore<T extends SyncEntity> {
  Future<List<T>> fetchAll(String userId);
  Future<void> upsert(T entity, String userId);
  Future<List<T>> fetchNotDeleted(String userId);
}
