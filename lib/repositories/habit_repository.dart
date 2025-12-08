import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohabit/models/habit.dart';

class HabitRepository {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _userHabits(String userId) =>
      _db.collection('habits').doc(userId).collection('items').withConverter<Map<String, dynamic>>(
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
}
