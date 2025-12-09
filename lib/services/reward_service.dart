import 'package:exohabit/models/exoplanet.dart';
import 'package:exohabit/repositories/exoplanet_repository.dart';

class RewardService {
  final ExoplanetRepository _exoplanetRepository;

  RewardService(this._exoplanetRepository);

  /// Award an exoplanet for completing a habit
  /// For now, creates a placeholder exoplanet record
  /// Later will integrate with NASA API and rarity system
  Future<String> awardExoplanet(
      String habitId, String userId, String completionId) async {
    // Generate a placeholder name for now
    // Later this will fetch from NASA API with rarity logic
    final exoplanetName = _generatePlaceholderName();

    final exoplanet = Exoplanet(
      id: '', // Will be set by Firestore
      name: exoplanetName,
      discoveryDate: DateTime.now(),
      habitCompletionId: completionId,
    );

    final exoplanetId = await _exoplanetRepository.createExoplanet(exoplanet, userId);
    return exoplanetId;
  }

  /// Generate a placeholder exoplanet name
  /// Later this will be replaced with NASA API data
  String _generatePlaceholderName() {
    final prefixes = ['Kepler', 'HD', 'Gliese', 'TRAPPIST', 'Proxima'];
    final numbers = List.generate(1000, (i) => i + 1);
    final prefix = prefixes[DateTime.now().millisecond % prefixes.length];
    final number = numbers[DateTime.now().millisecond % numbers.length];
    return '$prefix-$number b';
  }
}

