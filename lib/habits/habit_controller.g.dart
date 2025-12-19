// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HabitController)
const habitControllerProvider = HabitControllerProvider._();

final class HabitControllerProvider
    extends $NotifierProvider<HabitController, HabitEditState> {
  const HabitControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitControllerHash();

  @$internal
  @override
  HabitController create() => HabitController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HabitEditState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HabitEditState>(value),
    );
  }
}

String _$habitControllerHash() => r'5572173c95f7420f7b9d8f6e1d53b9246663fcf9';

abstract class _$HabitController extends $Notifier<HabitEditState> {
  HabitEditState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HabitEditState, HabitEditState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HabitEditState, HabitEditState>,
              HabitEditState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
