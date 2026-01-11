// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merge_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(habitMergeSyncService)
const habitMergeSyncServiceProvider = HabitMergeSyncServiceProvider._();

final class HabitMergeSyncServiceProvider
    extends $FunctionalProvider<SyncService, SyncService, SyncService>
    with $Provider<SyncService> {
  const HabitMergeSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitMergeSyncServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitMergeSyncServiceHash();

  @$internal
  @override
  $ProviderElement<SyncService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncService create(Ref ref) {
    return habitMergeSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncService>(value),
    );
  }
}

String _$habitMergeSyncServiceHash() =>
    r'c868d5bd437c2eccedc8796f4cc65ac38341666d';

@ProviderFor(completionMergeSyncService)
const completionMergeSyncServiceProvider =
    CompletionMergeSyncServiceProvider._();

final class CompletionMergeSyncServiceProvider
    extends $FunctionalProvider<SyncService, SyncService, SyncService>
    with $Provider<SyncService> {
  const CompletionMergeSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completionMergeSyncServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completionMergeSyncServiceHash();

  @$internal
  @override
  $ProviderElement<SyncService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncService create(Ref ref) {
    return completionMergeSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncService>(value),
    );
  }
}

String _$completionMergeSyncServiceHash() =>
    r'b9f82c7633a2797beaa878739a11123e2a7ffcfc';

@ProviderFor(mergeSyncCoordinator)
const mergeSyncCoordinatorProvider = MergeSyncCoordinatorProvider._();

final class MergeSyncCoordinatorProvider
    extends
        $FunctionalProvider<
          MergeSyncCoordinator,
          MergeSyncCoordinator,
          MergeSyncCoordinator
        >
    with $Provider<MergeSyncCoordinator> {
  const MergeSyncCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mergeSyncCoordinatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mergeSyncCoordinatorHash();

  @$internal
  @override
  $ProviderElement<MergeSyncCoordinator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MergeSyncCoordinator create(Ref ref) {
    return mergeSyncCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MergeSyncCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MergeSyncCoordinator>(value),
    );
  }
}

String _$mergeSyncCoordinatorHash() =>
    r'10ad4aa8b0bc6cbb84e4686b5839cb4c0657eb26';
