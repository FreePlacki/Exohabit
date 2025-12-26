import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'completion_local_store.g.dart';

@riverpod
CompletionLocalStore completionLocalStore(Ref ref) =>
    DriftCompletionLocalStore(ref.watch(databaseProvider));

abstract class CompletionLocalStore {
  Future<List<Completion>> forHabit(
    String habitId, {
    DateTime? from,
    DateTime? to,
  });

  Future<int> countDistinctDays(
    String habitId, {
    required DateTime from,
    required DateTime to,
  });

  Future<void> upsert(Completion completion);
  Stream<List<Completion>> watch();
}

class DriftCompletionLocalStore implements CompletionLocalStore {
  DriftCompletionLocalStore(AppDatabase db) : _db = db;

  final AppDatabase _db;

  $$CompletionsTableTableManager get _completions => _db.managers.completions;

  @override
  Future<List<Completion>> forHabit(
    String habitId, {
    DateTime? from,
    DateTime? to,
  }) {
    final query = _db.select(_db.completions)
      ..where(
        (c) =>
            c.habitId.equals(habitId) &
            c.completedAt.isBetweenValues(
              from ?? DateTime.fromMillisecondsSinceEpoch(0),
              to ?? DateTime.now(),
            ),
      );

    return query.get();
  }

  @override
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
      ..where(_db.completions.habitId.equals(habitId))
      ..where(_db.completions.completedAt.day.isBetweenValues(from.day, to.day));

    final row = await query.getSingle();
    return row.read(distinctDayCount) ?? 0;
  }

  @override
  Future<void> upsert(Completion completion) =>
      _db.completions.insertOnConflictUpdate(completion);

  @override
  Stream<List<Completion>> watch() => _completions.watch();
}
