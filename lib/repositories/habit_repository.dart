import 'package:cloud_firestore/cloud_firestore.dart';
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

  CollectionReference<Map<String, dynamic>> _userHabits(String userId) =>
      _db.collection('habits').doc(userId).collection('items').withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data()!,
            toFirestore: (map, _) => map,
          );

  CollectionReference<Map<String, dynamic>> _habitCompletions(String userId, String habitId) =>
      _db
          .collection('habits')
          .doc(userId)
          .collection('items')
          .doc(habitId)
          .collection('completions')
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data()!,
            toFirestore: (map, _) => map,
          );

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
    final completion = HabitCompletion(
      id: '', // Will be set by Firestore
      habitId: habitId,
      userId: userId,
      completedAt: completedAt,
    );
    final docRef = await _habitCompletions(userId, habitId).add(completion.toMap());
    return docRef.id;
  }

  @override
  Stream<List<HabitCompletion>> getCompletionsForHabit(String habitId, String userId) {
    return _habitCompletions(userId, habitId)
        .orderBy('completedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(HabitCompletion.fromDoc).toList());
  }

  @override
  Future<List<HabitCompletion>> getCompletionsForWeek(
      String habitId, String userId, DateTime weekStart) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    final snap = await _habitCompletions(userId, habitId)
        .where('completedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(weekStart),
            isLessThan: Timestamp.fromDate(weekEnd))
        .orderBy('completedAt', descending: true)
        .get();
    return snap.docs.map(HabitCompletion.fromDoc).toList();
  }

  @override
  Future<bool> isCompletedToday(String habitId, String userId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final snap = await _habitCompletions(userId, habitId)
        .where('completedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart),
            isLessThan: Timestamp.fromDate(todayEnd))
        .limit(1)
        .get();

    return snap.docs.isNotEmpty;
  }
}
