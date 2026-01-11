import 'package:drift/drift.dart';
import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'completion_local_store.g.dart';

@riverpod
CompletionLocalStore completionLocalStore(Ref ref) =>
    CompletionLocalStore(ref.watch(databaseProvider));

class CompletionLocalStore implements LocalSyncStore<Completion> {
  CompletionLocalStore(AppDatabase db) : _db = db;

  final AppDatabase _db;

  $$CompletionsTableTableManager get _completions => _db.managers.completions;

  @override
  Future<List<Completion>> unsynced() async {
    final rows = await _completions.filter((h) => h.synced(false)).get();
    return rows.map(Completion.new).toList();
  }

  @override
  Future<List<Completion>> fetchAll() async {
    final rows = await _completions.get();
    return rows.map(Completion.new).toList();
  }

  @override
  Future<Completion?> fetchById(String completionId) async {
    final row = await _completions
        .filter((h) => h.id(completionId))
        .getSingleOrNull();
    return row == null ? null : Completion(row);
  }

  @override
  Future<void> upsert(Completion completion) {
    final updatedRow = completion.copyRow(
      updatedAt: DateTime.timestamp(),
      synced: false,
    );

    return _db.into(_db.completions).insertOnConflictUpdate(updatedRow);
  }

  @override
  Future<void> markSynced(String completionId) {
    return _completions
        .filter((h) => h.id(completionId))
        .update((h) => h(synced: const Value(true)));
  }

  @override
  Future<void> clear() => _db.delete(_db.completions).go();

  @override
  Future<void> transaction(Future<void> Function() action) =>
      _db.transaction(action);

  Future<List<Completion>> forHabit(
    String habitId, {
    DateTime? from,
    DateTime? to,
  }) async {
    final query = _db.select(_db.completions)
      ..where((c) => c.habitId.equals(habitId))
      ..where((c) => c.deleted.equals(false))
      ..where(
        (c) => c.completedAt.isBetweenValues(
          from ?? DateTime.fromMillisecondsSinceEpoch(0),
          to ?? DateTime.now(),
        ),
      );

    final c = await query.get();
    return c.map(Completion.new).toList();
  }

  Future<int> countDistinctDays(
    String habitId, {
    required DateTime from,
    required DateTime to,
  }) async {
    const dayBucket = CustomExpression<int>(
      '("completions"."completed_at" / (24*60*60))',
    );

    final distinctDayCount = dayBucket.count(distinct: true);

    final query = _db.selectOnly(_db.completions)
      ..addColumns([distinctDayCount])
      ..where(_db.completions.deleted.equals(false))
      ..where(_db.completions.habitId.equals(habitId))
      ..where(
        _db.completions.completedAt.day.isBetweenValues(from.day, to.day),
      );

    final row = await query.getSingle();
    return row.read(distinctDayCount) ?? 0;
  }

  Stream<List<Completion>> watch() =>
      _completions.watch().map((rows) => rows.map(Completion.new).toList());
}
