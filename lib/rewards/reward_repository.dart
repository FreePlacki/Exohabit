import 'dart:async';

import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanets/exoplanet_repository.dart';
import 'package:exohabit/rewards/reward_extensions.dart';
import 'package:exohabit/rewards/reward_local_store.dart';
import 'package:exohabit/rewards/rewards_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reward_repository.g.dart';

final exoplanetsProvider = StreamProvider.autoDispose<List<Exoplanet>>((ref) {
  final rewardsStream = ref.watch(rewardRepositoryProvider).watchRewards();

  return rewardsStream.asyncMap((rewards) async {
    final repo = ref.watch(exoplanetRepositoryProvider);

    return (await Future.wait(
      rewards.map((r) => repo.getFromName(r.id)),
    )).whereType<Exoplanet>().toList();
  });
});

@riverpod
RewardRepository rewardRepository(Ref ref) => RewardRepository(
  localStore: ref.watch(rewardLocalStoreProvider),
  exoplanetRepository: ref.watch(exoplanetRepositoryProvider),
);

class RewardRepository {
  RewardRepository({
    required RewardLocalStore localStore,
    required ExoplanetRepository exoplanetRepository,
  }) : _localStore = localStore,
       _exoplanetRepository = exoplanetRepository;

  final RewardLocalStore _localStore;
  final ExoplanetRepository _exoplanetRepository;

  Future<void> awardRandom() async {
    final rewards = await watchRewards().first;
    final excluded = rewards.map((r) => r.id).toList();
    final exoplanet = await _exoplanetRepository.getRandom(excluded);
    await _localStore.upsert(
      RewardExtensions.create(exoplanetName: exoplanet.name),
    );
  }

  Stream<List<Reward>> watchRewards() =>
      _localStore.watch().map((hs) => hs.where((h) => !h.deleted).toList());
}
