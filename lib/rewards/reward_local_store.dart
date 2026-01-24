import 'package:drift/drift.dart';
import 'package:exohabit/database.dart';
import 'package:exohabit/rewards/rewards_table.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reward_local_store.g.dart';

@riverpod
RewardLocalStore rewardLocalStore(Ref ref) =>
    RewardLocalStore(ref.watch(databaseProvider));

class RewardLocalStore implements LocalSyncStore<Reward> {
  RewardLocalStore(AppDatabase db) : _db = db;

  final AppDatabase _db;

  $$RewardsTableTableManager get _rewards => _db.managers.rewards;

  @override
  Future<List<Reward>> unsynced() async {
    final rows = await _rewards.filter((h) => h.synced(false)).get();
    return rows.map(Reward.new).toList();
  }

  @override
  Future<List<Reward>> fetchAll() async {
    final rows = await _rewards.get();
    return rows.map(Reward.new).toList();
  }

  @override
  Future<Reward?> fetchById(String exoplanetName) async {
    final row = await _rewards
        .filter((h) => h.exoplanetName.name(exoplanetName))
        .getSingleOrNull();
    return row == null ? null : Reward(row);
  }

  @override
  Future<void> upsert(Reward reward) {
    final updatedRow = reward.copyRow(synced: false);

    return _db.into(_db.rewards).insertOnConflictUpdate(updatedRow);
  }

  @override
  Future<void> markSynced(String exoplanetName) {
    return _rewards
        .filter((h) => h.exoplanetName.name(exoplanetName))
        .update((h) => h(synced: const Value(true)));
  }

  @override
  Future<void> clear() => _db.delete(_db.rewards).go();

  @override
  Future<void> transaction(Future<void> Function() action) =>
      _db.transaction(action);

  Stream<List<Reward>> watch() =>
      _rewards.watch().map((rows) => rows.map(Reward.new).toList());
}
