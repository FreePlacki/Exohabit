import 'package:drift/drift.dart';
import 'package:exohabit/habits/habits_table.dart';

@DataClassName('Completion')
class Completions extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(Habits, #id)();
  DateTimeColumn get completedAt => dateTime()();
  /// Normalized day boundary (midnight UTC)
  DateTimeColumn get day => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};

  /// Enforce "once per day" at DB level
  @override
  List<String> get customConstraints => ['UNIQUE(habit_id, day)'];
}
