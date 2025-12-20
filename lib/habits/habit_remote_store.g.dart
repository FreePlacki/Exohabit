// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_remote_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firestore)
const firestoreProvider = FirestoreProvider._();

final class FirestoreProvider
    extends
        $FunctionalProvider<
          FirebaseFirestore,
          FirebaseFirestore,
          FirebaseFirestore
        >
    with $Provider<FirebaseFirestore> {
  const FirestoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firestoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firestoreHash();

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    return firestore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }
}

String _$firestoreHash() => r'597b1a9eb96f2fae51f5b578f4b5debe4f6d30c6';

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

String _$habitRemoteStoreHash() => r'b4144674e96738420cef613dfd7fc9a72461c8e2';
