import 'dart:async';

import 'package:exohabit/habits/habit_local_store.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_repository.g.dart';

@riverpod
HabitRepository habitRepository(Ref ref) =>
    HabitRepository(localStore: ref.watch(habitLocalStoreProvider));

class HabitRepository {
  HabitRepository({required HabitLocalStore localStore})
    : _localStore = localStore;

  final HabitLocalStore _localStore;

  Future<void> createHabit(Habit habit) =>
      _localStore.upsert(Habit(habit.row.copyWith(deleted: false)));

  Future<void> deleteHabit(Habit habit) =>
      _localStore.upsert(Habit(habit.row.copyWith(deleted: true)));

  Future<void> updateHabit(Habit habit) =>
      _localStore.upsert(Habit(habit.row.copyWith(deleted: false)));

  Stream<List<Habit>> watchHabits() =>
      _localStore.watch().map((hs) => hs.where((h) => !h.deleted).toList());
}
