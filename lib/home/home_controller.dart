import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/logger.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/sync/merge_sync_service.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

final syncMutation = Mutation<void>();

@riverpod
class HomeController extends _$HomeController {
  @override
  Future<void> build() async {}

  Future<void> sync() => syncMutation
      .run(ref, (tsx) async {
        await tsx
            .get(mergeSyncCoordinatorProvider)
            .sync(ref.read(currentUserIdProvider));
      })
      .catchError(
        (Object? e) => logger.e("Couldn't sync with remote.", error: e),
        test: (_) => true,
      );
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  HabitCategory? build() {
    return null; // null = no filter ("All")
  }

  void select(HabitCategory? category) {
    state = category;
  }

  void clear() {
    state = null;
  }
}
