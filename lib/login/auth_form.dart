import 'package:exohabit/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;
  const AuthForm({super.key, required this.isLogin});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoading = false;
  AuthFailure? remoteError;

  bool get isValidEmail {
    final text = email.text.trim();
    return text.contains('@') && text.length > 3;
  }

  bool get isValidPassword {
    final text = password.text.trim();
    return text.isNotEmpty;
  }

  bool get canSubmit => isValidEmail && isValidPassword && !isLoading;

  Future<void> submit() async {
    setState(() {
      isLoading = true;
      remoteError = null;
    });

    final repo = AuthRepository();

    final (user, error) = widget.isLogin
        ? await repo.signIn(email.text.trim(), password.text.trim())
        : await repo.signUp(email.text.trim(), password.text.trim());

    if (!mounted) return;

    setState(() {
      isLoading = false;
      remoteError = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Email'),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Password'),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),

        if (remoteError != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              remoteError!.message,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: canSubmit ? submit : null,
            child: isLoading
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(widget.isLogin ? 'Sign In' : 'Sign Up'),
          ),
        ),
      ],
    );
  }
}
