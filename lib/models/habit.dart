import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String id;
  final String title;
  final String description;
  final int frequencyPerWeek;
  final DateTime createdAt;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.frequencyPerWeek,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'frequencyPerWeek': frequencyPerWeek,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Habit.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Habit(
      id: doc.id,
      title: data['title'] as String,
      description: data['description'] as String,
      frequencyPerWeek: data['frequencyPerWeek'] as int,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
