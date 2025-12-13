import 'dart:async';

import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = NotifierProvider(LoginController.new);

// TODO: consider using https://pub.dev/packages/freezed
class AuthFormState {
  const AuthFormState({required this.isLoading, this.error});
  final bool isLoading;
  final String? error;

  AuthFormState copyWith({bool? isLoading, String? error}) {
    return AuthFormState(isLoading: isLoading ?? this.isLoading, error: error);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AuthFormState &&
        isLoading == other.isLoading &&
        error == other.error;
  }

  @override
  int get hashCode => Object.hash(isLoading, error);
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
