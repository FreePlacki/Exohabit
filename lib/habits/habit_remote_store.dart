import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohabit/habits/habit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_remote_store.g.dart';

@riverpod
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;

@riverpod
HabitRemoteStore habitRemoteStore(Ref ref) =>
    FirestoreHabitRemoteStore(ref.watch(firestoreProvider));

abstract class HabitRemoteStore {
  Stream<List<Habit>> watch(String userId);

  Future<String> create(Habit habit, String userId);
  Future<void> update(Habit habit, String userId);
  Future<void> delete(Habit habit, String userId);
}

class FirestoreHabitRemoteStore implements HabitRemoteStore {
  FirestoreHabitRemoteStore(FirebaseFirestore db) : _db = db;

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
  Future<String> create(Habit habit, String userId) async {
    final doc = _userHabits(userId).doc();
    await doc.set(habit.toFirestore());
    return doc.id;
  }

  @override
  Future<void> delete(Habit habit, String userId) =>
      _userHabits(userId).doc(habit.id).delete();

  @override
  Future<void> update(Habit habit, String userId) =>
      _userHabits(userId).doc(habit.id).update(habit.toFirestore());

  @override
  Stream<List<Habit>> watch(String userId) => _userHabits(userId)
      .snapshots()
      .map((snap) => snap.docs.map(HabitFirestore.fromFirestore).toList());
}
