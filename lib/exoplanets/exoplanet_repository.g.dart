// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exoplanet_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exoplanetRepository)
const exoplanetRepositoryProvider = ExoplanetRepositoryProvider._();

final class ExoplanetRepositoryProvider
    extends
        $FunctionalProvider<
          ExoplanetRepository,
          ExoplanetRepository,
          ExoplanetRepository
        >
    with $Provider<ExoplanetRepository> {
  const ExoplanetRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exoplanetRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exoplanetRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExoplanetRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExoplanetRepository create(Ref ref) {
    return exoplanetRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExoplanetRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExoplanetRepository>(value),
    );
  }
}

String _$exoplanetRepositoryHash() =>
    r'ac173a8b611c705b950cc46ffb16bfbf5a2afdcf';
