import 'dart:async';

import 'package:exohabit/habits/habit.dart';
import 'package:exohabit/habits/habit_edit_screen.dart';
import 'package:exohabit/habits/habits_screen.dart';
import 'package:exohabit/home/home_screen.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/login/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final auth = ref.read(supabaseAuthProvider);
  
  return GoRouter(
    initialLocation: '/',
    refreshListenable: SupabaseAuthListenable(auth),
    redirect: (context, state) {
      final user = ref.read(currentUserProvider);
      final isLoggedIn = user != null;
      final isOnAuthPage = state.uri.toString().startsWith('/auth');

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
}

class SupabaseAuthListenable extends ChangeNotifier {
  SupabaseAuthListenable(GoTrueClient auth) {
    _sub = auth.onAuthStateChange.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<AuthState> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
