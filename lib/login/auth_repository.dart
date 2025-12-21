import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

@riverpod
GoTrueClient supabaseAuth(Ref ref) => Supabase.instance.client.auth;

@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepository(auth: ref.watch(supabaseAuthProvider));

@riverpod
Stream<AuthState> authState(Ref ref) =>
    ref.watch(supabaseAuthProvider).onAuthStateChange;

@riverpod
Session? currentSession(Ref ref) {
  ref.watch(authStateProvider);
  return ref.watch(supabaseAuthProvider).currentSession;
}

@riverpod
User? currentUser(Ref ref) => ref.watch(currentSessionProvider)?.user;

@riverpod
String? currentUserId(Ref ref) => ref.watch(currentUserProvider)?.id;

class AuthFailure implements Exception {
  AuthFailure(this.message);

  factory AuthFailure.fromSupabase(AuthException? e) {
    if (e == null) {
      return AuthFailure('Authentication failed.');
    }

    final msg = e.message.toLowerCase();
    if (msg.contains('invalid login credentials')) {
      return AuthFailure('Invalid email or password.');
    }
    if (msg.contains('email not confirmed')) {
      return AuthFailure('Please confirm your email address.');
    }
    if (msg.contains('user already registered')) {
      return AuthFailure('This email is already registered.');
    }
    if (msg.contains('password')) {
      return AuthFailure('Password is too weak.');
    }
    if (msg.contains('network')) {
      return AuthFailure('Network error. Please check your connection.');
    }

    return AuthFailure('Authentication failed.');
  }

  final String message;

  @override
  String toString() => message;
}

class AuthRepository {
  AuthRepository({required GoTrueClient auth}) : _auth = auth;

  final GoTrueClient _auth;

  Future<User> signIn(String email, String password) async {
    try {
      final res = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      return res.user!;
    } on AuthException catch (err) {
      throw AuthFailure.fromSupabase(err);
    }
  }

  Future<User> signUp(String email, String password) async {
    try {
      final creds = await _auth.signUp(email: email, password: password);
      return creds.user!;
    } on AuthException catch (err) {
      throw AuthFailure.fromSupabase(err);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
