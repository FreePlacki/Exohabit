import 'dart:async';

import 'package:exohabit/auth/auth_repository.dart';
import 'package:exohabit/models/exoplanet.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/models/habit_completion.dart';
import 'package:exohabit/repositories/exoplanet_repository.dart';
import 'package:exohabit/repositories/habit_repository.dart';
import 'package:exohabit/services/reward_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

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
    createdAt: createdAt ?? DateTime.utc(2024, 1, 1),
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

Exoplanet buildExoplanet({
  String id = 'exo-1',
  String name = 'Kepler-22b',
  DateTime? discoveryDate,
  String completionId = 'completion-1',
}) {
  return Exoplanet(
    id: id,
    name: name,
    discoveryDate: discoveryDate ?? DateTime.utc(2024, 1, 2),
    habitCompletionId: completionId,
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
  Future<void> createHabit(Habit habit, String userId) async {
    _habits.add(habit);
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

class FakeExoplanetRepository implements ExoplanetRepository {
  FakeExoplanetRepository({List<Exoplanet>? initial})
      : _items = List.from(initial ?? []),
        _cacheItems = List.from(initial ?? []);

  final List<Exoplanet> _items;
  final List<Exoplanet> _cacheItems;

  @override
  Future<String> createExoplanet(Exoplanet exoplanet, String userId) async {
    final newId = exoplanet.id.isEmpty ? 'exo-${_items.length + 1}' : exoplanet.id;
    _items.add(
      Exoplanet(
        id: newId,
        name: exoplanet.name,
        discoveryDate: exoplanet.discoveryDate,
        habitCompletionId: exoplanet.habitCompletionId,
        hostname: exoplanet.hostname,
        planetRadius: exoplanet.planetRadius,
        planetMass: exoplanet.planetMass,
        orbitalPeriod: exoplanet.orbitalPeriod,
        equilibriumTemperature: exoplanet.equilibriumTemperature,
        discoveryMethod: exoplanet.discoveryMethod,
        discoveryYear: exoplanet.discoveryYear,
        distance: exoplanet.distance,
        isAwarded: exoplanet.isAwarded,
      ),
    );
    return newId;
  }

  @override
  Stream<List<Exoplanet>> watchExoplanets(String userId) {
    return Stream.value(List.unmodifiable(_items));
  }

  @override
  Future<List<Exoplanet>> getAvailablePlanets({int limit = 50}) async {
    return _cacheItems.where((p) => !p.isAwarded).take(limit).toList();
  }

  @override
  Future<void> refreshCache() async {
    // No-op for tests
  }

  @override
  Future<bool> shouldRefreshCache() async {
    return false; // Never refresh in tests
  }

  @override
  Future<void> markPlanetAwarded(String planetName) async {
    final index = _cacheItems.indexWhere((p) => p.name == planetName);
    if (index != -1) {
      _cacheItems[index] = Exoplanet(
        id: _cacheItems[index].id,
        name: _cacheItems[index].name,
        discoveryDate: _cacheItems[index].discoveryDate,
        habitCompletionId: _cacheItems[index].habitCompletionId,
        hostname: _cacheItems[index].hostname,
        planetRadius: _cacheItems[index].planetRadius,
        planetMass: _cacheItems[index].planetMass,
        orbitalPeriod: _cacheItems[index].orbitalPeriod,
        equilibriumTemperature: _cacheItems[index].equilibriumTemperature,
        discoveryMethod: _cacheItems[index].discoveryMethod,
        discoveryYear: _cacheItems[index].discoveryYear,
        distance: _cacheItems[index].distance,
        isAwarded: true,
      );
    }
  }
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<(User?, AuthFailure?)> signIn(String email, String password) async =>
      (null, null);

  @override
  Future<(User?, AuthFailure?)> signUp(String email, String password) async =>
      (null, null);

  @override
  Future<void> signOut() async {}
}

class FakeRewardService implements RewardService {
  @override
  Future<String> awardExoplanet(String habitId, String userId, String completionId) async {
    return 'exo-fake';
  }
}

class FakeUser extends Fake implements User {
  FakeUser({required this.email, required this.uid});

  @override
  final String email;

  @override
  final String uid;
}

class MockExoplanetRepository extends Mock implements ExoplanetRepository {}

