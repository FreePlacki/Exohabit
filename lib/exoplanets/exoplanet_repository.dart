import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanets/exoplanet_local_store.dart';
import 'package:exohabit/exoplanets/exoplanet_remote_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exoplanet_repository.g.dart';

@riverpod
ExoplanetRepository exoplanetRepository(Ref ref) => ExoplanetRepository(
  localStore: ref.watch(exoplanetLocalStoreProvider),
  remoteStore: ref.watch(exoplanetRemoteStoreProvider),
);

class ExoplanetRepository {
  ExoplanetRepository({
    required ExoplanetLocalStore localStore,
    required ExoplanetRemoteStore remoteStore,
  }) : _localStore = localStore,
       _remoteStore = remoteStore;

  final ExoplanetLocalStore _localStore;
  final ExoplanetRemoteStore _remoteStore;

  Future<void> _syncWithRemote() async {
    final hasData = await _localStore.exists();
    if (!hasData) {
      final exoplanets = await _remoteStore.fetchAll();
      for (final exoplanet in exoplanets) {
        await _localStore.upsert(exoplanet);
      }
    }
  }

  Future<Exoplanet> getRandom(List<String> excluded) async {
    await _syncWithRemote();

    const availablePlanetsWithTemperature = 30;
    final exoplanet = await _localStore.fetchRandom(
      excludedNames: excluded,
      withTemperature: excluded.length < availablePlanetsWithTemperature,
    );
    return exoplanet!;
  }

  Future<Exoplanet?> getFromName(String name) async {
    await _syncWithRemote();
    return _localStore.fetchByName(name);
  }
}
