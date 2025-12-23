import 'package:drift/drift.dart';

@DataClassName('Habit')
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get frequencyPerWeek => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
