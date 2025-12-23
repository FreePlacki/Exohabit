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

String _$authSyncListenerHash() => r'9ae4d580ebf7538d09b90951632f9b49d72b51fb';

@ProviderFor(PendingSyncDecisionNotifier)
const pendingSyncDecisionProvider = PendingSyncDecisionNotifierProvider._();

final class PendingSyncDecisionNotifierProvider
    extends
        $NotifierProvider<PendingSyncDecisionNotifier, PendingSyncDecision?> {
  const PendingSyncDecisionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingSyncDecisionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingSyncDecisionNotifierHash();

  @$internal
  @override
  PendingSyncDecisionNotifier create() => PendingSyncDecisionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PendingSyncDecision? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PendingSyncDecision?>(value),
    );
  }
}

String _$pendingSyncDecisionNotifierHash() =>
    r'4e89921d9efba3e0eb20dd3167e4f4e5c8fb0b38';

abstract class _$PendingSyncDecisionNotifier
    extends $Notifier<PendingSyncDecision?> {
  PendingSyncDecision? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PendingSyncDecision?, PendingSyncDecision?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PendingSyncDecision?, PendingSyncDecision?>,
              PendingSyncDecision?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

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
