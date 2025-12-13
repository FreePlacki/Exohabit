import 'package:exohabit/login/auth_form.dart';
import 'package:flutter/material.dart';

enum AuthMode { login, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _authMode = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(switch (_authMode) {
          AuthMode.login => 'Log In',
          AuthMode.signup => 'Sign Up',
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: AuthForm(authMode: _authMode)),
            TextButton(
              onPressed: () {
                setState(
                  () => switch (_authMode) {
                    AuthMode.login => _authMode = AuthMode.signup,
                    AuthMode.signup => _authMode = AuthMode.login,
                  },
                );
              },
              child: Text(switch (_authMode) {
                AuthMode.login => 'Create an account',
                AuthMode.signup => 'Already have an account?',
              }),
            ),
          ],
        ),
      ),
    );
  }
}
