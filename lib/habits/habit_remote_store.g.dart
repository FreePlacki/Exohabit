// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_remote_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supabaseClient)
const supabaseClientProvider = SupabaseClientProvider._();

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  const SupabaseClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseClientHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabaseClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseClientHash() => r'de6240783d7dddb57e07d034deb0ddf8e2fcc3e4';

@ProviderFor(habitRemoteStore)
const habitRemoteStoreProvider = HabitRemoteStoreProvider._();

final class HabitRemoteStoreProvider
    extends
        $FunctionalProvider<
          HabitRemoteStore,
          HabitRemoteStore,
          HabitRemoteStore
        >
    with $Provider<HabitRemoteStore> {
  const HabitRemoteStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitRemoteStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitRemoteStoreHash();

  @$internal
  @override
  $ProviderElement<HabitRemoteStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HabitRemoteStore create(Ref ref) {
    return habitRemoteStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HabitRemoteStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HabitRemoteStore>(value),
    );
  }
}

String _$habitRemoteStoreHash() => r'24936f16cfe79a9cad28051217eb4d74d6816d2e';
