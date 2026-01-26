import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:exohabit/rewards/reward_extensions.dart';
import 'package:exohabit/rewards/rewards_table.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'reward_remote_store.g.dart';

@riverpod
RewardRemoteStore rewardRemoteStore(Ref ref) =>
    RewardRemoteStore(ref.watch(supabaseClientProvider));

class RewardRemoteStore implements RemoteSyncStore<Reward> {
  RewardRemoteStore(this._db);

  final SupabaseClient _db;

  static const _table = 'Rewards';

  @override
  Future<void> upsert(Reward reward, String userId) {
    return _db.from(_table).upsert(reward.toRemote(userId));
  }

  @override
  Future<List<Reward>> fetchAll(String userId) async {
    final response = await _db.from(_table).select().eq('userId', userId);

    return response
        .map((row) => RewardExtensions.fromRemote(row, synced: false))
        .toList();
  }

  @override
  Future<List<Reward>> fetchNotDeleted(String userId) async {
    final rows = await _db.from(_table).select().eq('deleted', false);

    return rows
        .map((r) => RewardExtensions.fromRemote(r, synced: false))
        .toList();
  }
}
