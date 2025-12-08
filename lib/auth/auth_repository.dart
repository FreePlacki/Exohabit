import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthFailure {
  final String message;

  const AuthFailure(this.message);

  @override
  String toString() => message;
}

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  Future<(User?, AuthFailure?)> signIn(String email, String password) async {
    try {
      final creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (creds.user, null);
    } on FirebaseAuthException catch (e) {
      return (null, AuthFailure(_mapError(e)));
    } catch (_) {
      return (null, const AuthFailure('Something went wrong.'));
    }
  }

  Future<(User?, AuthFailure?)> signUp(String email, String password) async {
    try {
      final creds = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (creds.user, null);
    } on FirebaseAuthException catch (e) {
      return (null, AuthFailure(_mapError(e)));
    } catch (_) {
      return (null, const AuthFailure('Something went wrong.'));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  String _mapError(FirebaseAuthException e) {
    return e.message ?? 'Authentication error occurred.';
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email format.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password is too weak.';
      default:
        return 'Authentication failed. Try again.';
    }
  }
}

