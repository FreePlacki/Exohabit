// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exoplanet_remote_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exoplanetRemoteStore)
const exoplanetRemoteStoreProvider = ExoplanetRemoteStoreProvider._();

final class ExoplanetRemoteStoreProvider
    extends
        $FunctionalProvider<
          ExoplanetRemoteStore,
          ExoplanetRemoteStore,
          ExoplanetRemoteStore
        >
    with $Provider<ExoplanetRemoteStore> {
  const ExoplanetRemoteStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exoplanetRemoteStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exoplanetRemoteStoreHash();

  @$internal
  @override
  $ProviderElement<ExoplanetRemoteStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExoplanetRemoteStore create(Ref ref) {
    return exoplanetRemoteStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExoplanetRemoteStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExoplanetRemoteStore>(value),
    );
  }
}

String _$exoplanetRemoteStoreHash() =>
    r'ae968dd4cfa6f848b58aadc2db4152a1373cb59b';
