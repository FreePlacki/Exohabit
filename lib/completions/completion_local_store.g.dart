// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(completionLocalStore)
const completionLocalStoreProvider = CompletionLocalStoreProvider._();

final class CompletionLocalStoreProvider
    extends
        $FunctionalProvider<
          CompletionLocalStore,
          CompletionLocalStore,
          CompletionLocalStore
        >
    with $Provider<CompletionLocalStore> {
  const CompletionLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completionLocalStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completionLocalStoreHash();

  @$internal
  @override
  $ProviderElement<CompletionLocalStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompletionLocalStore create(Ref ref) {
    return completionLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompletionLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompletionLocalStore>(value),
    );
  }
}

String _$completionLocalStoreHash() =>
    r'4b3652fc3be93857f72120d2d8cf70babb04d7f2';

@ProviderFor(unsyncedCompletions)
const unsyncedCompletionsProvider = UnsyncedCompletionsProvider._();

final class UnsyncedCompletionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Completion>>,
          List<Completion>,
          Stream<List<Completion>>
        >
    with $FutureModifier<List<Completion>>, $StreamProvider<List<Completion>> {
  const UnsyncedCompletionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unsyncedCompletionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unsyncedCompletionsHash();

  @$internal
  @override
  $StreamProviderElement<List<Completion>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Completion>> create(Ref ref) {
    return unsyncedCompletions(ref);
  }
}

String _$unsyncedCompletionsHash() =>
    r'e698d7af8de592fdf7559378fd093369fc947254';
