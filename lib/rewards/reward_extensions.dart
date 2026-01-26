import 'package:exohabit/database.dart';
import 'package:exohabit/rewards/rewards_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

extension RewardExtensions on Reward {
  static Reward create({required String exoplanetName}) => Reward(
    RewardRow(
      exoplanetName: exoplanetName,
      createdAt: DateTime.now(),
      deleted: false,
      synced: false,
    ),
  );

  Map<String, dynamic> toRemote(String userId) => {
    'userId': userId,
    'pl_name': row.exoplanetName,
    'createdAt': toTimestampString(row.createdAt.toString()),
    'deleted': deleted,
  };

  static Reward fromRemote(
    Map<String, dynamic> reward, {
    required bool synced,
  }) {
    return Reward(
      RewardRow(
        exoplanetName: reward['pl_name'] as String,
        createdAt: DateTime.parse(reward['createdAt'] as String).toUtc(),
        deleted: reward['deleted'] as bool,
        synced: synced,
      ),
    );
  }
}
