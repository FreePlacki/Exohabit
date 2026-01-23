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
        isAutoDispose: false,
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

String _$authSyncListenerHash() => r'd094544662ca7421965b37eb7ee6d3ecc102d417';

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

@ProviderFor(habitOverrideSyncService)
const habitOverrideSyncServiceProvider = HabitOverrideSyncServiceProvider._();

final class HabitOverrideSyncServiceProvider
    extends
        $FunctionalProvider<
          OverrideSyncService<Habit>,
          OverrideSyncService<Habit>,
          OverrideSyncService<Habit>
        >
    with $Provider<OverrideSyncService<Habit>> {
  const HabitOverrideSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitOverrideSyncServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitOverrideSyncServiceHash();

  @$internal
  @override
  $ProviderElement<OverrideSyncService<Habit>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OverrideSyncService<Habit> create(Ref ref) {
    return habitOverrideSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OverrideSyncService<Habit> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OverrideSyncService<Habit>>(value),
    );
  }
}

String _$habitOverrideSyncServiceHash() =>
    r'efc4b0b10590e25387640ed06a0b6c3db09db923';

@ProviderFor(completionOverrideSyncService)
const completionOverrideSyncServiceProvider =
    CompletionOverrideSyncServiceProvider._();

final class CompletionOverrideSyncServiceProvider
    extends
        $FunctionalProvider<
          OverrideSyncService<Completion>,
          OverrideSyncService<Completion>,
          OverrideSyncService<Completion>
        >
    with $Provider<OverrideSyncService<Completion>> {
  const CompletionOverrideSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completionOverrideSyncServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completionOverrideSyncServiceHash();

  @$internal
  @override
  $ProviderElement<OverrideSyncService<Completion>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OverrideSyncService<Completion> create(Ref ref) {
    return completionOverrideSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OverrideSyncService<Completion> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OverrideSyncService<Completion>>(
        value,
      ),
    );
  }
}

String _$completionOverrideSyncServiceHash() =>
    r'749862ab5525d49bc91174c6c8a8e016b6a493f0';

@ProviderFor(overrideSyncCoordinator)
const overrideSyncCoordinatorProvider = OverrideSyncCoordinatorProvider._();

final class OverrideSyncCoordinatorProvider
    extends
        $FunctionalProvider<
          OverrideSyncCoordinator,
          OverrideSyncCoordinator,
          OverrideSyncCoordinator
        >
    with $Provider<OverrideSyncCoordinator> {
  const OverrideSyncCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overrideSyncCoordinatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overrideSyncCoordinatorHash();

  @$internal
  @override
  $ProviderElement<OverrideSyncCoordinator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OverrideSyncCoordinator create(Ref ref) {
    return overrideSyncCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OverrideSyncCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OverrideSyncCoordinator>(value),
    );
  }
}

String _$overrideSyncCoordinatorHash() =>
    r'f1263690ba5f89a7f8534e4e0eb3d8abd6faf055';
