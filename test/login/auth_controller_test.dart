import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/login/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  test('successful login clears loading and error', () async {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          FakeAuthRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final controller =
        container.read(loginControllerProvider.notifier);

    final states = <AuthFormState>[];
    container.listen(
      loginControllerProvider,
      (_, next) => states.add(next),
      fireImmediately: true,
    );

    await controller.submitLogin(
      email: 'a@b.com',
      password: '1234',
    );

    expect(states, [
      const AuthFormState(isLoading: false),
      const AuthFormState(isLoading: true),
      const AuthFormState(isLoading: false),
    ]);
  });
}
