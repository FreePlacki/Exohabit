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

class AuthException implements Exception {
  AuthException(this.message);

  factory AuthException.fromFirebase(FirebaseAuthException e) {
    final fallback = _fallbackMessage(e);

    return AuthException(switch (e.code) {
      'invalid-email' => 'Invalid email format.',
      'user-not-found' => 'Invalid email or password.',
      'wrong-password' => 'Incorrect password.',
      'email-already-in-use' => 'This email is already registered.',
      'weak-password' => 'Password is too weak.',
      'invalid-credential' => 'Invalid email or password.',
      'too-many-requests' =>
        'Too many failed attempts. Please try again later.',
      'user-disabled' => 'This account has been disabled.',
      'operation-not-allowed' => 'This sign-in method is not enabled.',
      'network-request-failed' =>
        'Network error. Please check your connection.',
      _ => fallback,
    });
  }

  final String message;

  static String _fallbackMessage(FirebaseAuthException e) {
    final msg = e.message?.toLowerCase() ?? '';

    if (msg.contains('internal error') || msg.contains('an error occurred')) {
      return 'Invalid email or password.';
    }

    return 'Authentication failed. Please check your email and password.';
  }

  @override
  String toString() => message;
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
    } on FirebaseAuthException catch (err) {
      return Result.error(AuthException.fromFirebase(err));
    }
  }

  Future<Result<User>> signUp(String email, String password) async {
    try {
      final creds = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.ok(creds.user!);
    } on FirebaseAuthException catch (err) {
      return Result.error(AuthException.fromFirebase(err));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
