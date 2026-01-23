import 'package:drift/drift.dart';

class Exoplanets extends Table {
  TextColumn get name => text()();
  TextColumn get hostName => text().nullable()();
  IntColumn get discYear => integer().nullable()();
  RealColumn get orbitalPeriod => real().nullable()();
  RealColumn get radius => real().nullable()();
  RealColumn get mass => real().nullable()();
  RealColumn get temperature => real().nullable()();
  RealColumn get syDistance => real().nullable()();
  TextColumn get discoveryMethod => text().nullable()();
  TextColumn get stSpectype => text().nullable()();

  @override
  Set<Column> get primaryKey => {name};
}
