import 'dart:async';

import 'package:exohabit/habits/habit.dart';
import 'package:exohabit/habits/habit_edit_screen.dart';
import 'package:exohabit/habits/habits_screen.dart';
import 'package:exohabit/home/home_screen.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/login/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/auth',
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    redirect: (context, state) {
      if (auth.isLoading) {
        return null;
      }

      final isLoggedIn = auth.value != null;
      final isOnAuthPage = state.uri.toString().startsWith('/auth');

      if (!isLoggedIn && !isOnAuthPage) {
        return '/auth';
      }

      if (isLoggedIn && isOnAuthPage) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/habits', builder: (context, state) => const HabitsScreen()),
      GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
      GoRoute(
        path: '/create-habit',
        builder: (context, state) => const HabitEditScreen(),
      ),
      GoRoute(
        path: '/edit-habit',
        builder: (context, state) {
          final habit = state.extra as Habit?;
          return HabitEditScreen(habit: habit);
        },
      ),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
