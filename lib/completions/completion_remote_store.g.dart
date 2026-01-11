// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_remote_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(completionRemoteStore)
const completionRemoteStoreProvider = CompletionRemoteStoreProvider._();

final class CompletionRemoteStoreProvider
    extends
        $FunctionalProvider<
          CompletionRemoteStore,
          CompletionRemoteStore,
          CompletionRemoteStore
        >
    with $Provider<CompletionRemoteStore> {
  const CompletionRemoteStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completionRemoteStoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completionRemoteStoreHash();

  @$internal
  @override
  $ProviderElement<CompletionRemoteStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompletionRemoteStore create(Ref ref) {
    return completionRemoteStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompletionRemoteStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompletionRemoteStore>(value),
    );
  }
}

String _$completionRemoteStoreHash() =>
    r'162ac76b27d6668adcfa93e5ed00c6f8c24f2237';
