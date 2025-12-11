import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohabit/models/exoplanet.dart';
import 'package:exohabit/services/exoplanet_api_service.dart';

abstract class ExoplanetRepository {
  Future<String> createExoplanet(Exoplanet exoplanet, String userId);
  Stream<List<Exoplanet>> watchExoplanets(String userId);

  // New methods for NASA API integration
  Future<List<Exoplanet>> getAvailablePlanets({int limit});
  Future<void> refreshCache();
  Future<bool> shouldRefreshCache();
  Future<void> markPlanetAwarded(String planetName);
}

class FirestoreExoplanetRepository implements ExoplanetRepository {
  final FirebaseFirestore _db;
  ExoplanetApiService? _apiService;

  FirestoreExoplanetRepository({
    FirebaseFirestore? firestore,
    ExoplanetApiService? apiService,
  })  : _db = firestore ?? FirebaseFirestore.instance,
        _apiService = apiService;

  // Lazy initialization of API service
  ExoplanetApiService get _getApiService {
    _apiService ??= ExoplanetApiService();
    return _apiService!;
  }

  CollectionReference<Map<String, dynamic>> _userExoplanets(String userId) =>
      _db.collection('users').doc(userId).collection('exoplanets').withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data()!,
        toFirestore: (map, _) => map,
      );

  // Global cache of available exoplanets from NASA
  CollectionReference<Map<String, dynamic>> get _exoplanetCache =>
      _db.collection('exoplanet_cache').withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data()!,
        toFirestore: (map, _) => map,
      );

  @override
  Future<String> createExoplanet(Exoplanet exoplanet, String userId) async {
    final docRef = await _userExoplanets(userId).add(exoplanet.toMap()).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw Exception('Create exoplanet timeout'),
    );
    return docRef.id;
  }

  @override
  Stream<List<Exoplanet>> watchExoplanets(String userId) {
    return _userExoplanets(userId)
        .orderBy('discoveryDate', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Exoplanet.fromDoc).toList());
  }

  @override
  Future<bool> shouldRefreshCache() async {
    try {
      // Check if we have any planets in cache
      final snapshot = await _exoplanetCache.limit(1).get();
      return snapshot.docs.isEmpty;
    } catch (e) {
      // If we can't check, assume we need to refresh
      return true;
    }
  }

  @override
  Future<void> refreshCache() async {
    try {
      final nasaPlanets = await _getApiService.fetchRandomPlanets(count: 50);
      if (nasaPlanets.isEmpty) return;

      final batch = _db.batch();
      for (final nasaPlanet in nasaPlanets) {
        final planet = nasaPlanet.toExoplanet();
        if (planet.name.isNotEmpty) {
          batch.set(_exoplanetCache.doc(planet.name), planet.toMap());
        }
      }
      await batch.commit();
    } catch (e) {
      // Silently fail - cache will be refreshed next time
    }
  }

  @override
  Future<List<Exoplanet>> getAvailablePlanets({int limit = 50}) async {
    try {
      // Get planets from cache with timeout to prevent hanging
      final snapshot = await _exoplanetCache.limit(limit).get().timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw Exception('Cache query timeout'),
      );
      return snapshot.docs.map((doc) => Exoplanet.fromDoc(doc)).toList();
    } catch (e) {
      print('Error getting available planets: $e');
      return [];
    }
  }

  @override
  Future<void> markPlanetAwarded(String planetName) async {
    try {
      final docRef = _exoplanetCache.doc(planetName);
      await docRef.update({'isAwarded': true}).timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw Exception('Mark planet awarded timeout'),
      );
    } catch (e) {
      // Don't fail if we can't update cache - planet is still awarded to user
      print('Failed to mark planet as awarded in cache: $e');
    }
  }
}

