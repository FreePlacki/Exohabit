// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_repository.dart';

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

String _$firestoreHash() => r'0e25e335c5657f593fc1baf3d9fd026e70bca7fa';

@ProviderFor(habitRepository)
const habitRepositoryProvider = HabitRepositoryProvider._();

final class HabitRepositoryProvider
    extends
        $FunctionalProvider<HabitRepository, HabitRepository, HabitRepository>
    with $Provider<HabitRepository> {
  const HabitRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitRepositoryHash();

  @$internal
  @override
  $ProviderElement<HabitRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HabitRepository create(Ref ref) {
    return habitRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HabitRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HabitRepository>(value),
    );
  }
}

String _$habitRepositoryHash() => r'97acc4f4fcd3c186f5c6fe61d8d1fdd3c3727d08';

@ProviderFor(habits)
const habitsProvider = HabitsProvider._();

final class HabitsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Habit>>,
          List<Habit>,
          Stream<List<Habit>>
        >
    with $FutureModifier<List<Habit>>, $StreamProvider<List<Habit>> {
  const HabitsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsHash();

  @$internal
  @override
  $StreamProviderElement<List<Habit>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Habit>> create(Ref ref) {
    return habits(ref);
  }
}

String _$habitsHash() => r'02abde52dc6a559dbf34d5222487b7fdb0b08ba4';
