import 'package:exohabit/sync/sync_service.dart';

abstract class LocalSyncStore<T extends SyncEntity> {
  Future<List<T>> unsynced();
  Future<List<T>> fetchAll();
  Future<T?> fetchById(String id);
  Future<void> upsert(T entity);
  Future<void> markSynced(String id);
}

abstract class RemoteSyncStore<T extends SyncEntity> {
  Future<List<T>> fetchAll(String userId);
  Future<void> upsert(T entity, String userId);
}
