import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'habit.freezed.dart';

@freezed
abstract class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String title,
    required String description,
    required int frequencyPerWeek,
    required DateTime createdAt,
    @Default(false) bool synced,
  }) = _Habit;

  factory Habit.create({
    required String title,
    required int frequencyPerWeek,
    String description = '',
  }) {
    assert(title.trim().isNotEmpty);
    assert(frequencyPerWeek > 0 && frequencyPerWeek <= 7);

    return Habit(
      id: const Uuid().v4(),
      title: title,
      description: description,
      frequencyPerWeek: frequencyPerWeek,
      createdAt: DateTime.now(),
    );
  }
}

extension HabitFirestore on Habit {
  Map<String, dynamic> toFirestore() => {
    'title': title,
    'description': description,
    'frequencyPerWeek': frequencyPerWeek,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  static Habit fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Habit(
      id: doc.id,
      title: data['title'] as String,
      description: data['description'] as String,
      frequencyPerWeek: data['frequencyPerWeek'] as int,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
