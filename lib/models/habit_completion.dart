import 'package:cloud_firestore/cloud_firestore.dart';

class HabitCompletion {
  final String id;
  final String habitId;
  final String userId;
  final DateTime completedAt;
  final String? exoplanetId; // nullable for future exoplanet linking

  HabitCompletion({
    required this.id,
    required this.habitId,
    required this.userId,
    required this.completedAt,
    this.exoplanetId,
  });

  Map<String, dynamic> toMap() {
    return {
      'habitId': habitId,
      'userId': userId,
      'completedAt': Timestamp.fromDate(completedAt),
      'exoplanetId': exoplanetId,
    };
  }

  factory HabitCompletion.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return HabitCompletion(
      id: doc.id,
      habitId: data['habitId'] as String,
      userId: data['userId'] as String,
      completedAt: (data['completedAt'] as Timestamp).toDate(),
      exoplanetId: data['exoplanetId'] as String?,
    );
  }
}

