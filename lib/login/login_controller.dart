import 'dart:async';

import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_controller.freezed.dart';

final loginControllerProvider = NotifierProvider(LoginController.new);

@freezed
abstract class AuthFormState with _$AuthFormState {
  const factory AuthFormState({required bool isLoading, String? error}) = _AuthFormState;
}

class LoginController extends Notifier<AuthFormState> {
  @override
  AuthFormState build() {
    return const AuthFormState(isLoading: false);
  }

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
    state = state.copyWith(isLoading: true);

    final repo = ref.read(authRepositoryProvider);

    final result = isLogin
        ? await repo.signIn(email, password)
        : await repo.signUp(email, password);

    switch (result) {
      case Ok():
        state = const AuthFormState(isLoading: false);
      case Error(error: final e):
        state = AuthFormState(isLoading: false, error: e.toString());
    }
  }
}
