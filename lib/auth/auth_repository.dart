import 'package:firebase_auth/firebase_auth.dart';

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
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email format.';
      case 'user-not-found':
        return 'Invalid email or password.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        final firebaseMessage = e.message?.toLowerCase() ?? '';
        if (firebaseMessage.contains('internal error') ||
            firebaseMessage.contains('an error occurred')) {
          return 'Invalid email or password.';
        }
        return 'Authentication failed. Please check your email and password.';
    }
  }
}

