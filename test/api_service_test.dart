import 'package:exohabit/services/exoplanet_api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExoplanetApiService apiService;

  setUp(() {
    apiService = ExoplanetApiService();
  });

  test('API service can be created', () {
    expect(apiService, isNotNull);
  });

  test('Can parse sample CSV data', () {
    const sampleCsv = '''kepoi_name,koi_disposition,koi_period,koi_time0bk,koi_impact,koi_duration,koi_depth,koi_prad,koi_teq,koi_insol,koi_steff,koi_slogg,koi_srad
K00001.01,CONFIRMED,2.470613377,122.763305,0.818,1.74319,14230.9,13.04,1339.0,761.46,5820.00,4.457,0.9640
K00002.01,CONFIRMED,3.522498,131.504507,0.0,2.6312,875.0,6.15,939.0,134.0,6040.0,4.5,0.98''';

    final planets = apiService.parseCsvToPlanets(sampleCsv);

    expect(planets.length, 2);
    expect(planets[0].name, 'K00001.01');
    expect(planets[0].hostname, 'Kepler-K00001');
    expect(planets[0].planetRadius, 13.04);
    expect(planets[0].orbitalPeriod, 2.470613377);
  });
}
