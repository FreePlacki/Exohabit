import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohabit/models/exoplanet.dart';

class ExoplanetRepository {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _userExoplanets(String userId) =>
      _db.collection('users').doc(userId).collection('exoplanets').withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data()!,
        toFirestore: (map, _) => map,
      );

  Future<String> createExoplanet(Exoplanet exoplanet, String userId) async {
    final docRef = await _userExoplanets(userId).add(exoplanet.toMap());
    return docRef.id;
  }

  Stream<List<Exoplanet>> watchExoplanets(String userId) {
    return _userExoplanets(userId)
        .orderBy('discoveryDate', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Exoplanet.fromDoc).toList());
  }
}

