import 'package:cloud_firestore/cloud_firestore.dart';

class Exoplanet {
  final String id;
  final String name;
  final DateTime discoveryDate; // when earned
  final String habitCompletionId; // links to completion
  // Future fields for NASA API: temperature, mass, orbitalPeriod, etc.

  Exoplanet({
    required this.id,
    required this.name,
    required this.discoveryDate,
    required this.habitCompletionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'discoveryDate': Timestamp.fromDate(discoveryDate),
      'habitCompletionId': habitCompletionId,
    };
  }

  factory Exoplanet.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Exoplanet(
      id: doc.id,
      name: data['name'] as String,
      discoveryDate: (data['discoveryDate'] as Timestamp).toDate(),
      habitCompletionId: data['habitCompletionId'] as String,
    );
  }
}

