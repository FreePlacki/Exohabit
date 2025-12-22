import 'dart:async';

import 'package:exohabit/habits/habit.dart';
import 'package:exohabit/habits/habit_local_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_repository.g.dart';

@riverpod
HabitRepository habitRepository(Ref ref) =>
    OfflineFirstHabitRepository(localStore: ref.watch(habitLocalStoreProvider));

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

  @override
  Future<void> createHabit(Habit habit) =>
      _localStore.upsert(habit.toLocal().copyWith(deleted: false));

  @override
  Future<void> deleteHabit(Habit habit) =>
      _localStore.upsert(habit.toLocal().copyWith(deleted: true));

  @override
  Future<void> updateHabit(Habit habit) =>
      _localStore.upsert(habit.toLocal().copyWith(deleted: false));

  @override
  Stream<List<Habit>> watchHabits() => _localStore.watch().map(
    (d) => d.where((h) => !h.deleted).map(HabitLocal.fromLocal).toList(),
  );
}
