import 'dart:math';

import 'package:exohabit/models/exoplanet.dart';
import 'package:exohabit/repositories/exoplanet_repository.dart';

class RewardService {
  final ExoplanetRepository _exoplanetRepository;
  final Random _random = Random();

  RewardService(this._exoplanetRepository);

  /// Award an exoplanet for completing a habit
  Future<String> awardExoplanet(
      String habitId, String userId, String completionId) async {
    try {
      // Get available planets from cache
      final availablePlanets = await _exoplanetRepository.getAvailablePlanets(limit: 20);

      if (availablePlanets.isNotEmpty) {
        // Pick a random planet
        final selectedPlanet = availablePlanets[_random.nextInt(availablePlanets.length)];
        print('Awarding planet: ${selectedPlanet.name}');

        // Create awarded planet for user
        final awardedPlanet = selectedPlanet.awardToUser(completionId);
        final exoplanetId = await _exoplanetRepository.createExoplanet(awardedPlanet, userId);

        // Mark planet as awarded (async, don't wait)
        _exoplanetRepository.markPlanetAwarded(selectedPlanet.name);

        return exoplanetId;
      } else {
        // Fallback to placeholder
        print('No planets available, using placeholder');
        return await _createPlaceholderPlanet(completionId, userId);
      }
    } catch (e) {
      // Fallback on any error
      print('Error awarding planet, using placeholder: $e');
      return await _createPlaceholderPlanet(completionId, userId);
    }
  }

  /// Create a placeholder exoplanet when NASA API is unavailable
  Future<String> _createPlaceholderPlanet(String completionId, String userId) async {
    final exoplanetName = _generatePlaceholderName();

    final exoplanet = Exoplanet(
      id: '',
      name: exoplanetName,
      discoveryDate: DateTime.now(),
      habitCompletionId: completionId,
      hostname: 'Unknown Star',
      discoveryMethod: 'Habit Tracker',
      discoveryYear: DateTime.now().year,
    );

    return await _exoplanetRepository.createExoplanet(exoplanet, userId);
  }

  /// Generate a placeholder exoplanet name
  String _generatePlaceholderName() {
    final prefixes = ['Kepler', 'HD', 'Gliese', 'TRAPPIST', 'Proxima'];
    final numbers = List.generate(1000, (i) => i + 1);
    final prefix = prefixes[DateTime.now().millisecond % prefixes.length];
    final number = numbers[DateTime.now().millisecond % numbers.length];
    return '$prefix-$number b';
  }
}

