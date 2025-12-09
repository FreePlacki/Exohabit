import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohabit/models/exoplanet.dart';

abstract class ExoplanetRepository {
  Future<String> createExoplanet(Exoplanet exoplanet, String userId);

  Stream<List<Exoplanet>> watchExoplanets(String userId);
}

class FirestoreExoplanetRepository implements ExoplanetRepository {
  final FirebaseFirestore _db;

  FirestoreExoplanetRepository({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _userExoplanets(String userId) =>
      _db.collection('users').doc(userId).collection('exoplanets').withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data()!,
            toFirestore: (map, _) => map,
          );

  @override
  Future<String> createExoplanet(Exoplanet exoplanet, String userId) async {
    final docRef = await _userExoplanets(userId).add(exoplanet.toMap());
    return docRef.id;
  }

  @override
  Stream<List<Exoplanet>> watchExoplanets(String userId) {
    return _userExoplanets(userId)
        .orderBy('discoveryDate', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Exoplanet.fromDoc).toList());
  }
}

