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
    completedAt: completedAt ?? DateTime.now(),
    exoplanetId: exoplanetId,
  );
}

class FakeHabitRepository implements HabitRepository {
  FakeHabitRepository({
    List<Habit>? initialHabits,
    Map<String, List<HabitCompletion>>? completions,
  })  : _habits = List.from(initialHabits ?? []),
        _completions = completions ?? {};

  final List<Habit> _habits;
  final Map<String, List<HabitCompletion>> _completions;

  @override
  Future<String> createHabit(Habit habit, String userId) async {
    _habits.add(habit);
    return '${_habits.length}';
  }

  @override
  Future<void> deleteHabit(String id, String userId) async {
    _habits.removeWhere((h) => h.id == id);
  }

  @override
  Future<void> updateHabit(Habit habit, String userId) async {
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      _habits[index] = habit;
    }
  }

  @override
  Stream<List<Habit>> watchHabits(String userId) =>
      Stream.value(List.unmodifiable(_habits));

  @override
  Future<String> recordCompletion(String habitId, String userId, DateTime completedAt) async {
    final completion = buildCompletion(
      id: 'completion-${DateTime.now().microsecondsSinceEpoch}',
      habitId: habitId,
      userId: userId,
      completedAt: completedAt,
    );
    _completions.putIfAbsent(habitId, () => []).add(completion);
    return completion.id;
  }

  @override
  Stream<List<HabitCompletion>> getCompletionsForHabit(String habitId, String userId) {
    return Stream.value(List.unmodifiable(_completions[habitId] ?? []));
  }

  @override
  Future<List<HabitCompletion>> getCompletionsForWeek(
      String habitId, String userId, DateTime weekStart) async {
    return List.unmodifiable(_completions[habitId] ?? []);
  }

  @override
  Future<bool> isCompletedToday(String habitId, String userId) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));
    return (_completions[habitId] ?? []).any(
      (c) => c.completedAt.isAfter(start) && c.completedAt.isBefore(end),
    );
  }
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
