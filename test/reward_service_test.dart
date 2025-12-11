import 'package:exohabit/services/reward_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'test_utils.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(buildExoplanet());
  });

  test('creates an exoplanet through the repository and returns its id', () async {
    final repo = MockExoplanetRepository();
    final availablePlanets = [buildExoplanet(name: 'Kepler-22b')];

    when(() => repo.createExoplanet(any(), any())).thenAnswer((_) async => 'exo-42');
    when(() => repo.getAvailablePlanets(limit: any(named: 'limit'))).thenAnswer((_) async => availablePlanets);
    when(() => repo.markPlanetAwarded(any())).thenAnswer((_) async {});

    final service = RewardService(repo);

    final exoplanetId = await service.awardExoplanet(
      'habit-1',
      'user-1',
      'completion-9',
    );

    expect(exoplanetId, 'exo-42');

    final captured = verify(() => repo.createExoplanet(captureAny(), 'user-1')).captured.single;
    final exoplanet = captured as dynamic;
    expect(exoplanet.habitCompletionId, 'completion-9');
    expect(exoplanet.name, 'Kepler-22b'); // Should use real planet data
  });

  test('falls back to placeholder when no planets available', () async {
    final repo = MockExoplanetRepository();

    when(() => repo.getAvailablePlanets(limit: any(named: 'limit'))).thenAnswer((_) async => []);
    when(() => repo.createExoplanet(any(), any())).thenAnswer((_) async => 'exo-fallback');

    final service = RewardService(repo);

    final exoplanetId = await service.awardExoplanet(
      'habit-1',
      'user-1',
      'completion-9',
    );

    expect(exoplanetId, 'exo-fallback');
  });
}

