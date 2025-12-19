import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_completion.freezed.dart';

@freezed
abstract class HabitCompletion with _$HabitCompletion {
  const factory HabitCompletion({
    required String id,
    required String habitId,
    required String userId,
    required DateTime completedAt,
    String? exoplanetId,
  }) = _HabitCompletion;

}

extension HabitCompletionFirestore on HabitCompletion {
  static HabitCompletion fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return HabitCompletion(
      id: doc.id,
      habitId: data['habitId'] as String,
      userId: data['userId'] as String,
      completedAt: (data['completedAt'] as Timestamp).toDate(),
      exoplanetId: data['exoplanetId'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'habitId': habitId,
      'userId': userId,
      'completedAt': Timestamp.fromDate(completedAt),
      'exoplanetId': exoplanetId,
    };
  }
}
