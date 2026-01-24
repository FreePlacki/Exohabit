// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todayHabits)
const todayHabitsProvider = TodayHabitsProvider._();

final class TodayHabitsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HabitToday>>,
          List<HabitToday>,
          Stream<List<HabitToday>>
        >
    with $FutureModifier<List<HabitToday>>, $StreamProvider<List<HabitToday>> {
  const TodayHabitsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayHabitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayHabitsHash();

  @$internal
  @override
  $StreamProviderElement<List<HabitToday>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HabitToday>> create(Ref ref) {
    return todayHabits(ref);
  }
}

String _$todayHabitsHash() => r'8d1b334a08f7cb979e68fe96c4cdfb8acb97ad6c';

@ProviderFor(completionRepository)
const completionRepositoryProvider = CompletionRepositoryProvider._();

final class CompletionRepositoryProvider
    extends
        $FunctionalProvider<
          CompletionRepository,
          CompletionRepository,
          CompletionRepository
        >
    with $Provider<CompletionRepository> {
  const CompletionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completionRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompletionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompletionRepository create(Ref ref) {
    return completionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompletionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompletionRepository>(value),
    );
  }
}

String _$completionRepositoryHash() =>
    r'969b36dff669edfb1db13bd6886534a3dca80897';
