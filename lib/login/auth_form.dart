import 'package:exohabit/habits/habit_repository.dart';
import 'package:exohabit/login/auth_controller.dart';
import 'package:exohabit/login/auth_screen.dart';
import 'package:exohabit/sync/sync_decision_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({super.key, required this.authMode});
  final AuthMode authMode;

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  bool get isValidEmail {
    final text = email.text.trim();
    return text.contains('@') && text.length > 3;
  }

  bool get isValidPassword {
    final text = password.text.trim();
    return text.isNotEmpty;
  }

  bool canSubmit() {
    final state = ref.read(authControllerProvider);
    return isValidEmail && isValidPassword && !state.isLoading;
  }

  Future<void> submit() async {
    final shouldAsk = await ref
        .watch(habitRepositoryProvider)
        .isMergePossible();
    if (!mounted) {
      return;
    }
    final result = shouldAsk
        ? await showDialog<SyncChoice>(
            context: context,
            barrierDismissible: false,
            builder: (_) => SyncDecisionDialog(
              isCreatingNewAccount: widget.authMode == AuthMode.signup,
            ),
          )
        : SyncChoice.override;
    final controller = ref.read(authControllerProvider.notifier);

    if (!mounted || result == null) {
      return;
    }
    switch (widget.authMode) {
      case AuthMode.login:
        await controller.submitLogin(
          email: email.text.trim(),
          password: password.text.trim(),
          syncChoice: result,
        );
      case AuthMode.signup:
        await controller.submitSignup(
          email: email.text.trim(),
          password: password.text.trim(),
          syncChoice: result,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    return Column(
      children: [
        TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Email'),
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) {
            passwordFocusNode.requestFocus();
          },
        ),
        const SizedBox(height: 12),
        TextField(
          controller: password,
          focusNode: passwordFocusNode,
          obscureText: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(labelText: 'Password'),
          onChanged: (_) => setState(() {}),
          onSubmitted: canSubmit() ? (_) => submit() : null,
        ),
        const SizedBox(height: 16),

        if (state.error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              state.error.toString(),
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: canSubmit() ? submit : null,
            child: state.isLoading
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(switch (widget.authMode) {
                    AuthMode.login => 'Log In',
                    AuthMode.signup => 'Sign Up',
                  }),
          ),
        ),
      ],
    );
  }
}
