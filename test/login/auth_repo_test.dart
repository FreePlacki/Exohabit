import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth auth;
  late AuthRepository repo;

  setUp(() {
    auth = MockFirebaseAuth();
    repo = AuthRepository(auth: auth);
  });

  test('signIn returns Ok(user) on success', () async {
    final creds = MockUserCredential();
    final user = MockUser();

    when(() => creds.user).thenReturn(user);
    when(
      () => auth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => creds);

    final result = await repo.signIn('a@b.com', 'hasloa');

    expect(result, isA<Ok<User>>());
  });

  test('signIn returns Err on FirebaseAuthException', () async {
    when(() => auth.signInWithEmailAndPassword(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenThrow(
      FirebaseAuthException(code: 'wrong-password'),
    );

    final result = await repo.signIn('a@b.com', '1234');

    expect(result, isA<Error<User>>());
    expect((result as Error<User>).error.toString(), 'Exception: Incorrect password.');
  });

  test('signUp returns Ok(user) on success', () async {
    final creds = MockUserCredential();
    final user = MockUser();

    when(() => creds.user).thenReturn(user);
    when(
      () => auth.createUserWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => creds);

    final result = await repo.signUp('a@b.com', 'hasloa');

    expect(result, isA<Ok<User>>());
  });

  test('signIn returns Err on FirebaseAuthException', () async {
    when(() => auth.createUserWithEmailAndPassword(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenThrow(
      FirebaseAuthException(code: 'wrong-password'),
    );

    final result = await repo.signUp('a@b.com', '1234');

    expect(result, isA<Error<User>>());
    expect((result as Error<User>).error.toString(), 'Exception: Incorrect password.');
  });

  test('signOut calls auth.signOut', () async {
    when(() => auth.signOut()).thenAnswer((_) async => {});

    await repo.signOut();

    verify(() => auth.signOut()).called(1);
  });
}
