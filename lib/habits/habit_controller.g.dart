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
    extends $AsyncNotifierProvider<HabitController, void> {
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
}

String _$habitControllerHash() => r'a02aafb288fa7c7557cc52c998166e57e4935bec';

abstract class _$HabitController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
