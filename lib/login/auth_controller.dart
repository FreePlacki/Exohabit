import 'dart:async';

import 'package:exohabit/logger.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/sync/merge_sync_service.dart';
import 'package:exohabit/sync/override_sync_service.dart';
import 'package:exohabit/sync/sync_decision_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<void> build() async {}

  Future<void> submitLogin({
    required String email,
    required String password,
    required SyncChoice syncChoice,
  }) => _submit(
    isLogin: true,
    email: email,
    password: password,
    choice: syncChoice,
  );

  Future<void> submitSignup({
    required String email,
    required String password,
    required SyncChoice syncChoice,
  }) => _submit(
    isLogin: false,
    email: email,
    password: password,
    choice: syncChoice,
  );

  Future<void> _submit({
    required bool isLogin,
    required String email,
    required String password,
    required SyncChoice choice,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final user = isLogin
          ? await ref.read(authRepositoryProvider).signIn(email, password)
          : await ref.read(authRepositoryProvider).signUp(email, password);
      await _sync(choice, user.id);
    });
  }

  Future<void> _sync(SyncChoice choice, String? userId) async {
    switch (choice) {
      case .merge:
        try {
          logger.i('Merge strategy chosen...');
          await ref.read(mergeSyncCoordinatorProvider).sync(userId);
        } on Exception catch (_) {
          logger.i('Merge failed overriding...');
          await ref.read(overrideSyncCoordinatorProvider).sync(userId);
        }
      case .override:
        logger.i('Override strategy chosen...');
        await ref.read(overrideSyncCoordinatorProvider).sync(userId);
    }
  }
}
