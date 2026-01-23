import 'dart:async';

import 'package:exohabit/exoplanets/exoplanet_repository.dart';
import 'package:exohabit/rewards/reward_extensions.dart';
import 'package:exohabit/rewards/reward_local_store.dart';
import 'package:exohabit/rewards/rewards_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reward_repository.g.dart';

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
    final exoplanet = await _exoplanetRepository.getRandom();
    await _localStore.upsert(
      RewardExtensions.create(exoplanetName: exoplanet.name),
    );
  }

  Stream<List<Reward>> watchRewards() =>
      _localStore.watch().map((hs) => hs.where((h) => !h.deleted).toList());
}
