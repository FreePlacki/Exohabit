import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/models/habit_completion.dart';

class HabitRepository {
  final _db = FirebaseFirestore.instance;

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

  Future<void> createHabit(Habit habit, String userId) async {
    await _userHabits(userId).add(habit.toMap());
  }

  Future<void> deleteHabit(String id, String userId) async {
    await _userHabits(userId).doc(id).delete();
  }

  Future<void> updateHabit(Habit habit, String userId) async {
    await _userHabits(userId)
        .doc(habit.id)
        .update(habit.toMap());
  }

  Stream<List<Habit>> watchHabits(String userId) {
    return _userHabits(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Habit.fromDoc).toList());
  }

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

  Stream<List<HabitCompletion>> getCompletionsForHabit(String habitId, String userId) {
    return _habitCompletions(userId, habitId)
        .orderBy('completedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(HabitCompletion.fromDoc).toList());
  }

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
