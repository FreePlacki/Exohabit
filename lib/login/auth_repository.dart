import 'package:exohabit/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(auth: ref.watch(firebaseAuthProvider));
}

@riverpod
Stream<User?> authState(Ref ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
}

@riverpod
String? currentUserId(Ref ref) {
  return ref.watch(authStateProvider).value?.uid;
}

class AuthRepository {
  AuthRepository({required FirebaseAuth auth}) : _auth = auth;

  final FirebaseAuth _auth;

  Future<Result<User>> signIn(String email, String password) async {
    try {
      final creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.ok(creds.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(Exception(_mapError(e)));
    }
  }

  Future<Result<User>> signUp(String email, String password) async {
    try {
      final creds = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.ok(creds.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(Exception(_mapError(e)));
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
