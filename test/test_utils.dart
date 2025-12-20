import 'dart:async';

import 'package:exohabit/completions/habit_completion.dart';
import 'package:exohabit/habits/habit.dart';
import 'package:exohabit/habits/habit_repository.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

import 'login/auth_repo_test.dart';

Habit buildHabit({
  String id = 'habit-1',
  String title = 'Drink water',
  String description = 'Stay hydrated',
  int frequencyPerWeek = 3,
  DateTime? createdAt,
}) {
  return Habit(
    id: id,
    title: title,
    description: description,
    frequencyPerWeek: frequencyPerWeek,
    createdAt: createdAt ?? DateTime.utc(2024),
  );
}

HabitCompletion buildCompletion({
  String id = 'completion-1',
  String habitId = 'habit-1',
  String userId = 'user-1',
  DateTime? completedAt,
  String? exoplanetId,
}) {
  return HabitCompletion(
    id: id,
    habitId: habitId,
    userId: userId,
    completedAt: completedAt ?? DateTime.timestamp(),
    exoplanetId: exoplanetId,
  );
}

class FakeHabitRepository implements HabitRepository {
  FakeHabitRepository({List<Habit>? initialHabits})
    : _habits = List.from(initialHabits ?? []);

  final List<Habit> _habits;

  @override
  Future<String> createHabit(Habit habit) async {
    _habits.add(habit);
    return '${_habits.length}';
  }

  @override
  Future<void> deleteHabit(Habit habit) async {
    _habits.removeWhere((h) => h.id == habit.id);
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      _habits[index] = habit;
    }
  }

  @override
  Stream<List<Habit>> watchHabits() => Stream.value(List.unmodifiable(_habits));
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<Result<User>> signIn(String email, String password) async =>
      Result.ok(MockUser());

  @override
  Future<Result<User>> signUp(String email, String password) async =>
      Result.ok(MockUser());

  @override
  Future<void> signOut() async {}
}

class FakeUser extends Fake implements User {
  FakeUser({required this.email, required this.uid});

  @override
  final String email;

  @override
  final String uid;
}
