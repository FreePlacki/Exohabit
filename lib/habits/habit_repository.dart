import 'dart:async';

import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habit.dart';
import 'package:exohabit/habits/habit_local_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_repository.g.dart';

@riverpod
HabitRepository habitRepository(Ref ref) =>
    OfflineFirstHabitRepository(localStore: ref.watch(habitLocalStoreProvider));
  
@riverpod
Stream<List<Habit>> habits(Ref ref) =>
    ref.watch(habitRepositoryProvider).watchHabits();

abstract class HabitRepository {
  Stream<List<Habit>> watchHabits();

  Future<void> createHabit(Habit habit);
  Future<void> deleteHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
}

class OfflineFirstHabitRepository implements HabitRepository {
  OfflineFirstHabitRepository({required HabitLocalStore localStore})
    : _localStore = localStore;

  final HabitLocalStore _localStore;

  static HabitTableData _fromLocalModel(Habit habit) => HabitTableData(
    id: habit.id,
    title: habit.title,
    description: habit.description,
    frequencyPerWeek: habit.frequencyPerWeek,
    createdAt: habit.createdAt,
    synced: false,
  );

  static Habit _toLocalModel(HabitTableData habit) => Habit(
    id: habit.id,
    title: habit.title,
    description: habit.description,
    frequencyPerWeek: habit.frequencyPerWeek,
    createdAt: habit.createdAt,
  );

  @override
  Future<void> createHabit(Habit habit) =>
      _localStore.upsert(_fromLocalModel(habit));

  @override
  Future<void> deleteHabit(Habit habit) =>
      _localStore.delete(_fromLocalModel(habit));

  @override
  Future<void> updateHabit(Habit habit) =>
      _localStore.upsert(_fromLocalModel(habit));

  @override
  Stream<List<Habit>> watchHabits() =>
      _localStore.watch().map((d) => d.map(_toLocalModel).toList());
}
