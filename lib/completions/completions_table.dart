import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/sync/sync_service.dart';

class Completion implements SyncEntity {
  Completion(this.row);
  final CompletionRow row;

  @override
  String get id => row.id;
  @override
  DateTime get updatedAt => row.updatedAt;
  @override
  bool get deleted => row.deleted;

  CompletionRow copyRow({
    DateTime? updatedAt,
    bool? synced,
  }) {
    return row.copyWith(
      updatedAt: updatedAt,
      synced: synced,
    );
  }
}

@DataClassName('CompletionRow')
class Completions extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id)();
  DateTimeColumn get completedAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
