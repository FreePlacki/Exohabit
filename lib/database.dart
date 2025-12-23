import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) => AppDatabase();

@DriftDatabase(tables: [Habits, Completions])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // TODO: web support https://drift.simonbinder.eu/platforms/web/
    return driftDatabase(name: 'exohabit');
  }
}
