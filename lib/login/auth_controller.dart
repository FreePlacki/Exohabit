import 'dart:async';

import 'package:exohabit/login/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<void> build() async {}

  Future<void> submitLogin({required String email, required String password}) =>
      _submit(isLogin: true, email: email, password: password);

  Future<void> submitSignup({
    required String email,
    required String password,
  }) => _submit(isLogin: false, email: email, password: password);

  Future<void> _submit({
    required bool isLogin,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      if (isLogin) {
        await repo.signIn(email, password);
      } else {
        await repo.signUp(email, password);
      }
    });
  }
}
