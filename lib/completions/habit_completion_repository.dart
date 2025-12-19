import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohabit/completions/habit_completion.dart';

abstract class HabitCompletionRepository {
  Future<String> recordCompletion(
    String habitId,
    String userId,
    DateTime completedAt,
  );

  Stream<List<HabitCompletion>> getCompletionsForHabit(
    String habitId,
    String userId,
  );

  Future<List<HabitCompletion>> getCompletionsForWeek(
    String habitId,
    String userId,
    DateTime weekStart,
  );

  Future<bool> isCompletedToday(String habitId, String userId);
}

class FirestoreHabitCompletionRepository implements HabitCompletionRepository {
  FirestoreHabitCompletionRepository({required FirebaseFirestore firestore})
    : _db = firestore;
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _completionsCollection {
    return _db
        .collection('completions')
        .withConverter<Map<String, dynamic>>(
          fromFirestore: (snap, _) => snap.data()!,
          toFirestore: (map, _) => map,
        );
  }

  @override
  Future<String> recordCompletion(
    String habitId,
    String userId,
    DateTime completedAt,
  ) async {
    final completion = HabitCompletion(
      id: '',
      habitId: habitId,
      userId: userId,
      completedAt: completedAt,
    );

    try {
      final docRef = await _completionsCollection.add(completion.toFirestore());
      return docRef.id;
    } catch (err) {
      // TODO: think about how to handle connection errors
      if (err.toString().contains('thread')) {
        throw Exception('Connection issue. Check your internet and try again.');
      }
      rethrow;
    }
  }

  @override
  Stream<List<HabitCompletion>> getCompletionsForHabit(
    String habitId,
    String userId,
  ) {
    return _completionsCollection
        .where('userId', isEqualTo: userId)
        .where('habitId', isEqualTo: habitId)
        .orderBy('completedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(HabitCompletionFirestore.fromFirestore).toList());
  }

  @override
  Future<List<HabitCompletion>> getCompletionsForWeek(
    String habitId,
    String userId,
    DateTime weekStart,
  ) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    final snap = await _completionsCollection
        .where('userId', isEqualTo: userId)
        .get();

    final allUserCompletions = snap.docs.map(HabitCompletionFirestore.fromFirestore).toList();
    // Filter in memory, TODO
    final weekCompletions = allUserCompletions.where((c) {
      return c.habitId == habitId &&
          c.completedAt.isAfter(weekStart) &&
          c.completedAt.isBefore(weekEnd);
    }).toList()..sort((a, b) => b.completedAt.compareTo(a.completedAt));

    return weekCompletions;
  }

  @override
  Future<bool> isCompletedToday(String habitId, String userId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final snap = await _completionsCollection
        .where('userId', isEqualTo: userId)
        .where('habitId', isEqualTo: habitId)
        .where('completedAt', isGreaterThanOrEqualTo: todayStart)
        .where('completedAt', isLessThan: todayEnd)
        .limit(1)
        .get();

    return snap.docs.isNotEmpty;
  }
}
