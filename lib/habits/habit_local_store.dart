import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_local_store.g.dart';

@riverpod
HabitLocalStore habitLocalStore(Ref ref) =>
    DriftHabitLocalStore(ref.watch(databaseProvider));

abstract class HabitLocalStore {
  Stream<List<HabitTableData>> watch();
  Future<List<HabitTableData>> unsynced();
  Future<HabitTableData?> fetchById(String habitId);

  Future<void> upsert(HabitTableData habit);
  Future<void> delete(HabitTableData habit);
  Future<void> markSynced(String habitId);
  Future<void> clear();
  Future<void> transaction(Future<void> Function() action);
}

class DriftHabitLocalStore implements HabitLocalStore {
  DriftHabitLocalStore(AppDatabase db) : _db = db;

  final AppDatabase _db;

  $$HabitTableTableTableManager get _habits => _db.managers.habitTable;

  @override
  Stream<List<HabitTableData>> watch() => _habits.watch();

  @override
  Future<List<HabitTableData>> unsynced() =>
      _habits.filter((h) => h.synced(false)).get();

  @override
  Future<HabitTableData?> fetchById(String habitId) =>
      _habits.filter((h) => h.id(habitId)).getSingleOrNull();

  @override
  Future<void> upsert(HabitTableData habit) => _db
      .into(_db.habitTable)
      .insertOnConflictUpdate(
        habit.copyWith(updatedAt: DateTime.timestamp(), synced: false),
      );

  @override
  Future<void> delete(HabitTableData habit) =>
      _db.delete(_db.habitTable).delete(habit);

  @override
  Future<void> markSynced(String habitId) => _habits
      .filter((h) => h.id(habitId))
      .update((h) => h(synced: const Value(true)));

  @override
  Future<void> clear() => _db.delete(_db.habitTable).go();

  @override
  Future<void> transaction(Future<void> Function() action) =>
      _db.transaction(action);
}
