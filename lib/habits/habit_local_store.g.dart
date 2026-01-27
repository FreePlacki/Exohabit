// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(unsyncedHabits)
const unsyncedHabitsProvider = UnsyncedHabitsProvider._();

final class UnsyncedHabitsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Habit>>,
          List<Habit>,
          Stream<List<Habit>>
        >
    with $FutureModifier<List<Habit>>, $StreamProvider<List<Habit>> {
  const UnsyncedHabitsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unsyncedHabitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unsyncedHabitsHash();

  @$internal
  @override
  $StreamProviderElement<List<Habit>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Habit>> create(Ref ref) {
    return unsyncedHabits(ref);
  }
}

String _$unsyncedHabitsHash() => r'8255118fca24780e6abce7685e5363a5e68e0415';

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

String _$habitLocalStoreHash() => r'a6711f8b02b9ff1feaf7b9107a8987cb2ceb1641';
