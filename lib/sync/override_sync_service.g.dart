// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'override_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authSyncListener)
const authSyncListenerProvider = AuthSyncListenerProvider._();

final class AuthSyncListenerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  const AuthSyncListenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSyncListenerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSyncListenerHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return authSyncListener(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$authSyncListenerHash() => r'3603547b04ecb9755c66a3f5ba5f2637f03fb4e4';

@ProviderFor(overrideSyncService)
const overrideSyncServiceProvider = OverrideSyncServiceProvider._();

final class OverrideSyncServiceProvider
    extends $FunctionalProvider<SyncService, SyncService, SyncService>
    with $Provider<SyncService> {
  const OverrideSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overrideSyncServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overrideSyncServiceHash();

  @$internal
  @override
  $ProviderElement<SyncService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncService create(Ref ref) {
    return overrideSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncService>(value),
    );
  }
}

String _$overrideSyncServiceHash() =>
    r'344f6ef4e981d9769bc3bc6d36a7b3f95f376f22';
