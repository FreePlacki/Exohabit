abstract class SyncService {
  Future<void> sync(String userId);
}

abstract class SyncEntity {
  String get id;
  DateTime get updatedAt;
  bool get deleted;
}
