import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_local_store.g.dart';

@riverpod
HabitLocalStore habitLocalStore(Ref ref) =>
    DriftHabitLocalStore(ref.watch(databaseProvider));

abstract class HabitLocalStore {
  Stream<List<Habit>> watch();
  Future<List<Habit>> unsynced();
  Future<Habit?> fetchById(String habitId);

  Future<void> upsert(Habit habit);
  Future<void> delete(Habit habit);
  Future<void> markSynced(String habitId);
  Future<void> clear();
  Future<void> transaction(Future<void> Function() action);
  Future<bool> hasAny();
}

class DriftHabitLocalStore implements HabitLocalStore {
  DriftHabitLocalStore(AppDatabase db) : _db = db;

  final AppDatabase _db;

  $$HabitsTableTableManager get _habits => _db.managers.habits;

  @override
  Stream<List<Habit>> watch() => _habits.watch();

  @override
  Future<List<Habit>> unsynced() =>
      _habits.filter((h) => h.synced(false)).get();

  @override
  Future<Habit?> fetchById(String habitId) =>
      _habits.filter((h) => h.id(habitId)).getSingleOrNull();

  @override
  Future<void> upsert(Habit habit) => _db
      .into(_db.habits)
      .insertOnConflictUpdate(
        habit.copyWith(updatedAt: DateTime.timestamp(), synced: false),
      );

  @override
  Future<void> delete(Habit habit) =>
      _db.delete(_db.habits).delete(habit);

  @override
  Future<void> markSynced(String habitId) => _habits
      .filter((h) => h.id(habitId))
      .update((h) => h(synced: const Value(true)));

  @override
  Future<void> clear() => _db.delete(_db.habits).go();

  @override
  Future<void> transaction(Future<void> Function() action) =>
      _db.transaction(action);

  @override
  Future<bool> hasAny() => _habits.exists();
}
