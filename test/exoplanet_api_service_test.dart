import 'package:exohabit/services/exoplanet_api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExoplanetApiService', () {
    late ExoplanetApiService service;

    setUp(() {
      service = ExoplanetApiService();
    });

    test('_parseCsvToPlanets parses CSV correctly', () {
      const csvData = '''kepoi_name,koi_disposition,koi_period,koi_time0bk,koi_impact,koi_duration,koi_depth,koi_prad,koi_teq,koi_insol,koi_steff,koi_slogg,koi_srad
K00001.01,CONFIRMED,2.470613377,122.763305,0.818,1.74319,14230.9,13.04,1339.0,761.46,5820.00,4.457,0.9640
K00002.01,CONFIRMED,3.522498,131.504507,0.0,2.6312,875.0,6.15,939.0,134.0,6040.0,4.5,0.98''';

      final planets = service.parseCsvToPlanets(csvData);

      expect(planets.length, 2);

      final k1 = planets[0];
      expect(k1.name, 'K00001.01');
      expect(k1.hostname, 'Kepler-K00001');
      expect(k1.planetRadius, 13.04);
      expect(k1.planetMass, null); // Not available
      expect(k1.orbitalPeriod, 2.470613377);
      expect(k1.equilibriumTemperature, 1339.0);
      expect(k1.discoveryMethod, 'Transit');
      expect(k1.discoveryYear, 2014);
      expect(k1.distance, null); // Not available

      final k2 = planets[1];
      expect(k2.name, 'K00002.01');
      expect(k2.hostname, 'Kepler-K00002');
      expect(k2.planetRadius, 6.15);
    });

    test('parseCsvLine handles quoted values', () {
      final service = ExoplanetApiService();
      final result = service.parseCsvLine('"Kepler-22b","Kepler-22",2.4');
      expect(result, ['Kepler-22b', 'Kepler-22', '2.4']);
    });

    test('parseCsvLine handles unquoted values', () {
      final service = ExoplanetApiService();
      final result = service.parseCsvLine('Kepler-22b,Kepler-22,2.4');
      expect(result, ['Kepler-22b', 'Kepler-22', '2.4']);
    });
  });
}
