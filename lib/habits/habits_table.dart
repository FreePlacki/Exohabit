import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habit_category.dart';
import 'package:exohabit/sync/sync_service.dart';

class Habit implements SyncEntity {
  Habit(this.row);
  final HabitRow row;

  @override
  String get id => row.id;
  @override
  DateTime get updatedAt => row.updatedAt;
  @override
  bool get deleted => row.deleted;

  HabitRow copyRow({DateTime? updatedAt, bool? synced}) {
    return row.copyWith(updatedAt: updatedAt, synced: synced);
  }
}

@DataClassName('HabitRow')
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get frequencyPerWeek => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get category => intEnum<HabitCategory>()();

  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
