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

  Future<void> sync() => syncMutation.run(ref, (tsx) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      await ref.read(mergeSyncServiceProvider).sync(userId);
    }
  });
}
