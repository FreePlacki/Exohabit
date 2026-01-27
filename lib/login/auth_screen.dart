import 'dart:math';

import 'package:exohabit/login/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: max(
                MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
                0,
              ),
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const .all(16),
                child: Column(
                  spacing: 16,
                  children: [
                    Expanded(child: AuthForm(authMode: _authMode)),
                    Column(
                      mainAxisAlignment: .end,
                      children: [
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
                        TextButton(
                          onPressed: () {
                            context.go('/');
                          },
                          child: const Text('Continue without an account'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
