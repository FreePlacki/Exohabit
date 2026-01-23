import 'package:exohabit/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exoplanet_local_store.g.dart';

@riverpod
ExoplanetLocalStore exoplanetLocalStore(Ref ref) =>
    ExoplanetLocalStore(ref.watch(databaseProvider));

class ExoplanetLocalStore {
  ExoplanetLocalStore(AppDatabase db) : _db = db;

  final AppDatabase _db;

  $$ExoplanetsTableTableManager get _exoplanets => _db.managers.exoplanets;

  Future<List<Exoplanet>> fetchAll() async {
    final rows = await _exoplanets.get();
    return rows;
  }

  Future<Exoplanet?> fetchByName(String name) async {
    final row = await _exoplanets.filter((h) => h.name(name)).getSingleOrNull();
    return row;
  }

  Future<Exoplanet?> fetchRandom() async {
    final row = await _db
        .customSelect(
          'SELECT * from Exoplanets ORDER BY RANDOM() LIMIT 1',
          readsFrom: {_db.exoplanets},
        )
        .getSingleOrNull();
    return row == null ? null : _db.exoplanets.map(row.data);
  }

  Future<void> upsert(Exoplanet exoplanet) {
    return _db.into(_db.exoplanets).insertOnConflictUpdate(exoplanet);
  }

  Future<void> clear() => _db.delete(_db.exoplanets).go();

  Future<bool> exists() => _exoplanets.exists();
}
