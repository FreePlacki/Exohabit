import 'package:exohabit/services/exoplanet_api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExoplanetApiService apiService;

  setUp(() {
    apiService = ExoplanetApiService();
  });

  test('API service can be created without crashing', () {
    expect(apiService, isNotNull);
  });

  test('CSV parsing works', () {
    const sampleCsv = '''kepoi_name,koi_disposition,koi_period,koi_prad,koi_teq
K00001.01,CONFIRMED,2.47,13.04,1339
K00002.01,CONFIRMED,3.52,6.15,939''';

    final planets = apiService.parseCsvToPlanets(sampleCsv);

    expect(planets.length, 2);
    expect(planets[0].name, 'K00001.01');
    expect(planets[1].name, 'K00002.01');
  });
}
