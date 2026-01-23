// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exoplanet_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exoplanetLocalStore)
const exoplanetLocalStoreProvider = ExoplanetLocalStoreProvider._();

final class ExoplanetLocalStoreProvider
    extends
        $FunctionalProvider<
          ExoplanetLocalStore,
          ExoplanetLocalStore,
          ExoplanetLocalStore
        >
    with $Provider<ExoplanetLocalStore> {
  const ExoplanetLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exoplanetLocalStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exoplanetLocalStoreHash();

  @$internal
  @override
  $ProviderElement<ExoplanetLocalStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExoplanetLocalStore create(Ref ref) {
    return exoplanetLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExoplanetLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExoplanetLocalStore>(value),
    );
  }
}

String _$exoplanetLocalStoreHash() =>
    r'7a55ea32f00b6189f3c8a623e265ad77f4c05700';
