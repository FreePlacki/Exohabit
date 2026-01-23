// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rewardLocalStore)
const rewardLocalStoreProvider = RewardLocalStoreProvider._();

final class RewardLocalStoreProvider
    extends
        $FunctionalProvider<
          RewardLocalStore,
          RewardLocalStore,
          RewardLocalStore
        >
    with $Provider<RewardLocalStore> {
  const RewardLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rewardLocalStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rewardLocalStoreHash();

  @$internal
  @override
  $ProviderElement<RewardLocalStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RewardLocalStore create(Ref ref) {
    return rewardLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RewardLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RewardLocalStore>(value),
    );
  }
}

String _$rewardLocalStoreHash() => r'a3060e4fb6c05ca64fb452669ed2989d2a4ba758';
