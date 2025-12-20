import 'package:exohabit/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_local_store.g.dart';

@riverpod
HabitLocalStore habitLocalStore(Ref ref) =>
    DriftHabitLocalStore(ref.watch(databaseProvider));

abstract class HabitLocalStore {
  Stream<List<HabitTableData>> watch();

  Future<void> upsert(HabitTableData habit);
  Future<void> delete(HabitTableData habit);
}

class DriftHabitLocalStore implements HabitLocalStore {
  DriftHabitLocalStore(AppDatabase db) : _db = db;

  final AppDatabase _db;

  $$HabitTableTableTableManager get _habits => _db.managers.habitTable;

  @override
  Stream<List<HabitTableData>> watch() {
    return _habits.watch();
  }

  @override
  Future<void> upsert(HabitTableData habit) {
    return _db.into(_db.habitTable).insertOnConflictUpdate(habit);
  }

  @override
  Future<void> delete(HabitTableData habit) {
    return _db.delete(_db.habitTable).delete(habit);
  }
}
