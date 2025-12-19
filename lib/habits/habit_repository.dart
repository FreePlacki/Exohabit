import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohabit/habits/habit.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_repository.g.dart';

@riverpod
FirebaseFirestore firestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
HabitRepository habitRepository(Ref ref) {
  return FirestoreHabitRepository(firestore: ref.watch(firestoreProvider));
}

@riverpod
Stream<List<Habit>> habits(Ref ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) {
    return const Stream.empty();
  }
  return ref.watch(habitRepositoryProvider).watchHabits(userId);
}

abstract class HabitRepository {
  Future<String> createHabit(Habit habit, String userId);

  Future<void> deleteHabit(String id, String userId);

  Future<void> updateHabit(Habit habit, String userId);

  Stream<List<Habit>> watchHabits(String userId);
}

class FirestoreHabitRepository implements HabitRepository {
  FirestoreHabitRepository({required FirebaseFirestore firestore})
    : _db = firestore;
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _userHabits(String userId) => _db
      .collection('habits')
      .doc(userId)
      .collection('items')
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data()!,
        toFirestore: (map, _) => map,
      );

  @override
  Future<String> createHabit(Habit habit, String userId) async {
      final doc = _userHabits(userId).doc();
      await doc.set(habit.toFirestore());
      return doc.id;
  }

  @override
  Future<void> deleteHabit(String id, String userId) =>
      _userHabits(userId).doc(id).delete();

  @override
  Future<void> updateHabit(Habit habit, String userId) =>
      _userHabits(userId).doc(habit.id).update(habit.toFirestore());

  @override
  Stream<List<Habit>> watchHabits(String userId) => _userHabits(userId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map(HabitFirestore.fromFirestore).toList());
}
