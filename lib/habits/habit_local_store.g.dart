// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(habitLocalStore)
const habitLocalStoreProvider = HabitLocalStoreProvider._();

final class HabitLocalStoreProvider
    extends
        $FunctionalProvider<HabitLocalStore, HabitLocalStore, HabitLocalStore>
    with $Provider<HabitLocalStore> {
  const HabitLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitLocalStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitLocalStoreHash();

  @$internal
  @override
  $ProviderElement<HabitLocalStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HabitLocalStore create(Ref ref) {
    return habitLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HabitLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HabitLocalStore>(value),
    );
  }
}

String _$habitLocalStoreHash() => r'b919629e4420dab3abb679fb9ff588fa77ae882e';
