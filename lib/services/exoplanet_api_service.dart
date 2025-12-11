import 'package:dio/dio.dart';
import 'package:exohabit/models/exoplanet.dart';

/// Service for interacting with NASA Exoplanet Archive API
class ExoplanetApiService {
  static const String _baseUrl = 'https://exoplanetarchive.ipac.caltech.edu';
  static const String _apiEndpoint = '/cgi-bin/nstedAPI/nph-nstedAPI';

  final Dio _dio;

  ExoplanetApiService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: _baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 30),
              headers: {
                'User-Agent': 'ExoHabit-App/1.0',
                'Accept': 'application/json,text/csv',
              },
            ));

  /// Fetch confirmed planets from NASA API
  /// Returns a list of planets with basic information
  Future<List<NasaExoplanet>> fetchConfirmedPlanets({
    int limit = 1000,
    int offset = 0,
  }) async {
      try {
          final response = await _dio.get(
            _apiEndpoint,
            queryParameters: {
              'table': 'cumulative',
              'format': 'csv',
              'select': 'kepoi_name,koi_disposition,koi_period,koi_time0bk,koi_impact,koi_duration,koi_depth,koi_prad,koi_teq,koi_insol,koi_steff,koi_slogg,koi_srad',
              'order': 'kepoi_name',
              'limit': limit,
              'offset': offset,
            },
          );

          if (response.statusCode == 200) {
            final csvData = response.data as String;
            final planets = parseCsvToPlanets(csvData);
            return planets;
      } else {
        throw Exception('Failed to fetch planets: ${response.statusCode}');
      }
        } on DioException catch (e) {
          print('DioException in fetchConfirmedPlanets: ${e.message}');
          print('DioException type: ${e.type}');
          print('DioException response: ${e.response}');
          if (e.response != null) {
            print('Response status: ${e.response?.statusCode}');
            print('Response headers: ${e.response?.headers}');
            print('Response data: ${e.response?.data}');
          }
          throw Exception('Network error: ${e.message}');
        } catch (e, stack) {
          print('Unexpected error in fetchConfirmedPlanets: $e');
          print('Stack trace: $stack');
          throw Exception('Unexpected error: $e');
        }
  }

  /// Parse CSV data into NasaExoplanet objects
  List<NasaExoplanet> parseCsvToPlanets(String csvData) {
    final lines = csvData.split('\n');
    if (lines.length < 2) return []; // Need at least header + one data row

    final headers = lines[0].split(',').map((h) => h.trim()).toList();
    final planets = <NasaExoplanet>[];

    for (int i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      final values = parseCsvLine(line);
      if (values.length == headers.length) {
        final planet = _createPlanetFromCsvRow(headers, values);
        if (planet != null) {
          planets.add(planet);
        }
      }
    }

    return planets;
  }

  /// Parse a single CSV line, handling quoted values
  List<String> parseCsvLine(String line) {
    final values = <String>[];
    bool inQuotes = false;
    String currentValue = '';

    for (int i = 0; i < line.length; i++) {
      final char = line[i];

      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        values.add(currentValue.trim());
        currentValue = '';
      } else {
        currentValue += char;
      }
    }

    // Add the last value
    values.add(currentValue.trim());

    return values;
  }

  /// Create NasaExoplanet from CSV row data
  NasaExoplanet? _createPlanetFromCsvRow(List<String> headers, List<String> values) {
    final data = <String, String>{};

    for (int i = 0; i < headers.length && i < values.length; i++) {
      data[headers[i]] = values[i];
    }

    // Only create planet if we have a name and it's confirmed
    final name = data['kepoi_name'];
    final disposition = data['koi_disposition'];
    if (name == null || name.isEmpty || disposition != 'CONFIRMED') return null;

    return NasaExoplanet(
      name: name,
      hostname: 'Kepler-${name.split('.').first}',
      planetRadius: _parseDouble(data['koi_prad']),
      planetMass: null, // Not available in cumulative table
      orbitalPeriod: _parseDouble(data['koi_period']),
      equilibriumTemperature: _parseDouble(data['koi_teq']),
      discoveryMethod: 'Transit', // Kepler data is transit method
      discoveryYear: 2014, // Kepler mission
      distance: null, // Not available in cumulative table
    );
  }

  /// Parse string to double, handling empty/null values
  double? _parseDouble(String? value) {
    if (value == null || value.isEmpty) return null;
    return double.tryParse(value);
  }

  /// Parse string to int, handling empty/null values
  int? _parseInt(String? value) {
    if (value == null || value.isEmpty) return null;
    return int.tryParse(value);
  }

  /// Fetch planets for the cache
  Future<List<NasaExoplanet>> fetchRandomPlanets({int count = 50}) async {
    // Just fetch the first N planets - simple and fast
    return await fetchConfirmedPlanets(limit: count, offset: 0);
  }
}

/// NASA Exoplanet data model (API response format)
class NasaExoplanet {
  final String name;
  final String? hostname;
  final double? planetRadius; // Earth radii
  final double? planetMass; // Earth masses
  final double? orbitalPeriod; // days
  final double? equilibriumTemperature; // Kelvin
  final String? discoveryMethod;
  final int? discoveryYear;
  final double? distance; // parsecs

  NasaExoplanet({
    required this.name,
    this.hostname,
    this.planetRadius,
    this.planetMass,
    this.orbitalPeriod,
    this.equilibriumTemperature,
    this.discoveryMethod,
    this.discoveryYear,
    this.distance,
  });

  factory NasaExoplanet.fromJson(Map<String, dynamic> json) {
    return NasaExoplanet(
      name: json['kepoi_name'] as String? ?? '',
      hostname: 'Kepler-${(json['kepoi_name'] as String?)?.split('.').first ?? ''}',
      planetRadius: (json['koi_prad'] as num?)?.toDouble(),
      planetMass: null, // Not available in cumulative table
      orbitalPeriod: (json['koi_period'] as num?)?.toDouble(),
      equilibriumTemperature: (json['koi_teq'] as num?)?.toDouble(),
      discoveryMethod: 'Transit', // Kepler data is transit method
      discoveryYear: 2014, // Kepler mission
      distance: null, // Not available in cumulative table
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hostname': hostname,
      'planetRadius': planetRadius,
      'planetMass': planetMass,
      'orbitalPeriod': orbitalPeriod,
      'equilibriumTemperature': equilibriumTemperature,
      'discoveryMethod': discoveryMethod,
      'discoveryYear': discoveryYear,
      'distance': distance,
    };
  }

  /// Convert to our Exoplanet model for caching
  Exoplanet toExoplanet() {
    return Exoplanet(
      id: name, // Use planet name as ID for caching
      name: name,
      discoveryDate: DateTime.now(), // Will be overridden when awarded
      habitCompletionId: '', // Will be set when awarded
      hostname: hostname,
      planetRadius: planetRadius,
      planetMass: planetMass,
      orbitalPeriod: orbitalPeriod,
      equilibriumTemperature: equilibriumTemperature,
      discoveryMethod: discoveryMethod,
      discoveryYear: discoveryYear,
      distance: distance,
      isAwarded: false,
    );
  }
}

