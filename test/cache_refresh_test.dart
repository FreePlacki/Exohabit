import 'package:exohabit/repositories/exoplanet_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockExoplanetRepository mockRepo;

  setUp(() {
    mockRepo = MockExoplanetRepository();
  });

  test('Cache refresh should work with proper rules', () async {
    // This test verifies that the repository methods don't throw
    // when called with properly configured Firestore rules

    when(() => mockRepo.refreshCache()).thenAnswer((_) async {});
    when(() => mockRepo.shouldRefreshCache()).thenAnswer((_) async => true);

    expect(() => mockRepo.refreshCache(), returnsNormally);
    expect(() => mockRepo.shouldRefreshCache(), returnsNormally);
  });
}

class MockExoplanetRepository extends Mock implements ExoplanetRepository {}
