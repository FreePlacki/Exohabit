import 'dart:async';

import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanets/exoplanet_repository.dart';
import 'package:exohabit/rewards/reward_extensions.dart';
import 'package:exohabit/rewards/reward_local_store.dart';
import 'package:exohabit/rewards/rewards_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reward_repository.g.dart';

final rewardsProvider = StreamProvider.autoDispose<List<Reward>>((ref) {
  return ref.watch(rewardRepositoryProvider).watchRewards();
});

final unlockedExoplanetsProvider = Provider<AsyncValue<List<Exoplanet>>>((ref) {
  final rewardsAsync = ref.watch(rewardsProvider);
  final exoplanetsAsync = ref.watch(exoplanetsProvider);

  return rewardsAsync.when(
    loading: () => const AsyncLoading(),
    error: AsyncError.new,
    data: (rewards) {
      return exoplanetsAsync.when(
        loading: () => const AsyncLoading(),
        error: AsyncError.new,
        data: (exoplanets) {
          final rewardIds = rewards.map((r) => r.id).toSet();

          final filtered = exoplanets
              .where((e) => rewardIds.contains(e.name))
              .toList();

          return AsyncData(filtered);
        },
      );
    },
  );
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

  Future<Exoplanet?> awardRandom() async {
    final rewards = await watchRewards().first;
    final excluded = rewards.map((r) => r.id).toList();
    final exoplanet = await _exoplanetRepository.getRandom(excluded);
    if (exoplanet == null) {
      return null;
    }
    await _localStore.upsert(
      RewardExtensions.create(exoplanetName: exoplanet.name),
    );
    return exoplanet;
  }

  Stream<List<Reward>> watchRewards() =>
      _localStore.watch().map((hs) => hs.where((h) => !h.deleted).toList());
}
