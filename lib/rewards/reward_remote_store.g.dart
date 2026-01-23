// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_remote_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rewardRemoteStore)
const rewardRemoteStoreProvider = RewardRemoteStoreProvider._();

final class RewardRemoteStoreProvider
    extends
        $FunctionalProvider<
          RewardRemoteStore,
          RewardRemoteStore,
          RewardRemoteStore
        >
    with $Provider<RewardRemoteStore> {
  const RewardRemoteStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rewardRemoteStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rewardRemoteStoreHash();

  @$internal
  @override
  $ProviderElement<RewardRemoteStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RewardRemoteStore create(Ref ref) {
    return rewardRemoteStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RewardRemoteStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RewardRemoteStore>(value),
    );
  }
}

String _$rewardRemoteStoreHash() => r'216b03ad629a5207753a9e35ae2cb679e88424c2';
