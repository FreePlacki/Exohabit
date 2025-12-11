import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/models/habit_completion.dart';

abstract class HabitRepository {
  Future<void> createHabit(Habit habit, String userId);

  Future<void> deleteHabit(String id, String userId);

  Future<void> updateHabit(Habit habit, String userId);

  Stream<List<Habit>> watchHabits(String userId);

  Future<String> recordCompletion(String habitId, String userId, DateTime completedAt);

  Stream<List<HabitCompletion>> getCompletionsForHabit(String habitId, String userId);

  Future<List<HabitCompletion>> getCompletionsForWeek(
      String habitId, String userId, DateTime weekStart);

  Future<bool> isCompletedToday(String habitId, String userId);
}

class FirestoreHabitRepository implements HabitRepository {
  final FirebaseFirestore _db;

  FirestoreHabitRepository({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  /// Helper to run a Firestore operation with timeout protection
  Future<T> _withTimeout<T>(Future<T> operation, [Duration timeout = const Duration(seconds: 10)]) {
    return Future.any([
      operation,
      Future.delayed(timeout, () => throw Exception('Firestore operation timed out')),
    ]);
  }

  CollectionReference<Map<String, dynamic>> _userHabits(String userId) =>
      _db.collection('habits').doc(userId).collection('items').withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data()!,
            toFirestore: (map, _) => map,
          );

  CollectionReference<Map<String, dynamic>> get _completionsCollection {
    return _db
        .collection('completions')
        .withConverter<Map<String, dynamic>>(
          fromFirestore: (snap, _) => snap.data()!,
          toFirestore: (map, _) => map,
        );
  }

  @override
  Future<void> createHabit(Habit habit, String userId) async {
    await _userHabits(userId).add(habit.toMap());
  }

  @override
  Future<void> deleteHabit(String id, String userId) async {
    await _userHabits(userId).doc(id).delete();
  }

  @override
  Future<void> updateHabit(Habit habit, String userId) async {
    await _userHabits(userId).doc(habit.id).update(habit.toMap());
  }

  @override
  Stream<List<Habit>> watchHabits(String userId) {
    return _userHabits(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Habit.fromDoc).toList());
  }

  @override
  Future<String> recordCompletion(String habitId, String userId, DateTime completedAt) async {
    // Verify authentication
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || currentUser.uid != userId) {
      throw Exception('Authentication required');
    }

    final completion = HabitCompletion(
      id: '',
      habitId: habitId,
      userId: userId,
      completedAt: completedAt,
    );

    try {
      final docRef = await _withTimeout(
        _completionsCollection.add(completion.toMap()),
        const Duration(seconds: 15),
      );
      return docRef.id;
    } catch (e) {
      if (e.toString().contains('thread') || e is TimeoutException) {
        throw Exception('Connection issue. Check your internet and try again.');
      }
      rethrow;
    }
  }

  @override
  Stream<List<HabitCompletion>> getCompletionsForHabit(String habitId, String userId) {
    return _completionsCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snap) {
          final completions = snap.docs.map(HabitCompletion.fromDoc).toList();
          return completions
              .where((c) => c.habitId == habitId)
              .toList()
            ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
        });
  }

  @override
  Future<List<HabitCompletion>> getCompletionsForWeek(
      String habitId, String userId, DateTime weekStart) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    final snap = await _completionsCollection
        .where('userId', isEqualTo: userId)
        .get();

    final allUserCompletions = snap.docs.map(HabitCompletion.fromDoc).toList();
    // Filter in memory
    final weekCompletions = allUserCompletions.where((c) {
      return c.habitId == habitId &&
             c.completedAt.isAfter(weekStart) &&
             c.completedAt.isBefore(weekEnd);
    }).toList();

    // Sort in memory
    weekCompletions.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return weekCompletions;
  }

  @override
  Future<bool> isCompletedToday(String habitId, String userId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final snap = await _completionsCollection
        .where('userId', isEqualTo: userId)
        .get();

    // Filter in memory
    return snap.docs.any((doc) {
      final completion = HabitCompletion.fromDoc(doc);
      return completion.habitId == habitId &&
             completion.completedAt.isAfter(todayStart) &&
             completion.completedAt.isBefore(todayEnd);
    });
  }
}
