import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/exoplanets/exoplanets_table.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/rewards/rewards_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) => AppDatabase();

@DriftDatabase(tables: [Habits, Completions, Exoplanets, Rewards])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'exohabit',
      web: .new(
        sqlite3Wasm: .parse('sqlite3.wasm'),
        driftWorker: .parse('drift_worker.dart.js'),
      ),
    );
  }

  Future<void> deleteEverything() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}
