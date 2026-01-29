import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_local_store.g.dart';

@riverpod
Stream<List<Habit>> unsyncedHabits(Ref ref) =>
    ref.read(habitLocalStoreProvider).watchUnsynced();

@riverpod
HabitLocalStore habitLocalStore(Ref ref) =>
    HabitLocalStore(ref.read(databaseProvider));

class HabitLocalStore implements LocalSyncStore<Habit> {
  HabitLocalStore(this._db);

  final AppDatabase _db;

  $$HabitsTableTableManager get _habits => _db.managers.habits;

  Stream<List<Habit>> watch() =>
      _habits.watch().map((rows) => rows.map(Habit.new).toList());

  @override
  Future<List<Habit>> unsynced() async {
    final rows = await _habits.filter((h) => h.synced(false)).get();
    return rows.map(Habit.new).toList();
  }

  Stream<List<Habit>> watchUnsynced() {
    final rows = _habits.filter((h) => h.synced(false)).watch();
    return rows.map((l) => l.map(Habit.new).toList());
  }

  @override
  Future<List<Habit>> fetchAll() async {
    final rows = await _habits.get();
    return rows.map(Habit.new).toList();
  }

  @override
  Future<Habit?> fetchById(String habitId) async {
    final row = await _habits.filter((h) => h.id(habitId)).getSingleOrNull();
    return row == null ? null : Habit(row);
  }

  @override
  Future<void> upsert(Habit habit, {bool synced = false}) {
    final updatedRow = habit.copyRow(
      updatedAt: DateTime.now(),
      synced: synced,
      hasBeenSynced: habit.row.hasBeenSynced || synced,
    );

    return _db.into(_db.habits).insertOnConflictUpdate(updatedRow);
  }

  Future<void> delete(Habit habit) {
    return _db.delete(_db.habits).delete(habit.row);
  }

  @override
  Future<void> markSynced(String habitId) {
    return _habits
        .filter((h) => h.id(habitId))
        .update(
          (h) => h(synced: const Value(true), hasBeenSynced: const Value(true)),
        );
  }

  @override
  Future<void> clear() => _db.delete(_db.habits).go();

  @override
  Future<void> transaction(Future<void> Function() action) =>
      _db.transaction(action);

  Future<bool> hasAny() => _habits.exists();

  Future<bool> anyHasBeenSynced() =>
      _habits.filter((h) => h.hasBeenSynced(true)).exists();
}
