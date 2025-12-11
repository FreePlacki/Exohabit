import 'package:cloud_firestore/cloud_firestore.dart';

class Exoplanet {
  final String id;
  final String name;
  final DateTime discoveryDate; // when earned by user
  final String habitCompletionId; // links to completion
  final String? hostname; // star name
  final double? planetRadius; // in Earth radii
  final double? planetMass; // in Earth masses
  final double? orbitalPeriod; // in days
  final double? equilibriumTemperature; // in Kelvin
  final String? discoveryMethod;
  final int? discoveryYear;
  final double? distance; // in parsecs
  final bool isAwarded; // whether this planet has been awarded to a user

  Exoplanet({
    required this.id,
    required this.name,
    required this.discoveryDate,
    required this.habitCompletionId,
    this.hostname,
    this.planetRadius,
    this.planetMass,
    this.orbitalPeriod,
    this.equilibriumTemperature,
    this.discoveryMethod,
    this.discoveryYear,
    this.distance,
    this.isAwarded = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'discoveryDate': Timestamp.fromDate(discoveryDate),
      'habitCompletionId': habitCompletionId,
      'hostname': hostname,
      'planetRadius': planetRadius,
      'planetMass': planetMass,
      'orbitalPeriod': orbitalPeriod,
      'equilibriumTemperature': equilibriumTemperature,
      'discoveryMethod': discoveryMethod,
      'discoveryYear': discoveryYear,
      'distance': distance,
      'isAwarded': isAwarded,
    };
  }

  factory Exoplanet.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Exoplanet(
      id: doc.id,
      name: data['name'] as String,
      discoveryDate: (data['discoveryDate'] as Timestamp).toDate(),
      habitCompletionId: data['habitCompletionId'] as String,
      hostname: data['hostname'] as String?,
      planetRadius: (data['planetRadius'] as num?)?.toDouble(),
      planetMass: (data['planetMass'] as num?)?.toDouble(),
      orbitalPeriod: (data['orbitalPeriod'] as num?)?.toDouble(),
      equilibriumTemperature: (data['equilibriumTemperature'] as num?)?.toDouble(),
      discoveryMethod: data['discoveryMethod'] as String?,
      discoveryYear: data['discoveryYear'] as int?,
      distance: (data['distance'] as num?)?.toDouble(),
      isAwarded: data['isAwarded'] as bool? ?? false,
    );
  }

  // Create a copy for awarding to a user
  Exoplanet awardToUser(String completionId) {
    return Exoplanet(
      id: '',
      name: name,
      discoveryDate: DateTime.now(),
      habitCompletionId: completionId,
      hostname: hostname,
      planetRadius: planetRadius,
      planetMass: planetMass,
      orbitalPeriod: orbitalPeriod,
      equilibriumTemperature: equilibriumTemperature,
      discoveryMethod: discoveryMethod,
      discoveryYear: discoveryYear,
      distance: distance,
      isAwarded: true,
    );
  }
}

