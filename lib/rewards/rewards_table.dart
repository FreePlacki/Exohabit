import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanets/exoplanets_table.dart';
import 'package:exohabit/sync/sync_service.dart';

class Reward implements SyncEntity {
  Reward(this.row);
  final RewardRow row;

  @override
  String get id => row.exoplanetName;
  @override
  DateTime get updatedAt => row.createdAt;
  @override
  bool get deleted => row.deleted;

  RewardRow copyRow({DateTime? createdAt, bool? synced}) {
    return row.copyWith(createdAt: createdAt, synced: synced);
  }
}

@DataClassName('RewardRow')
class Rewards extends Table {
  TextColumn get exoplanetName => text().references(Exoplanets, #name)();

  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {exoplanetName};
}
