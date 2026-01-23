import 'package:exohabit/database.dart';

extension ExoplanetExtensions on Exoplanet {
  Map<String, dynamic> toRemote() => {
    'pl_name': name,
    'hostname': hostName,
    'disc_year': discYear,
    'pl_orbper': orbitalPeriod,
    'pl_rade': radius,
    'pl_masse': mass,
    'pl_eqt': temperature,
    'sy_dist': syDistance,
    'discoverymethod': discoveryMethod,
    'st_spectype': stSpectype,
  };

  static double? _toDouble(dynamic v) {
    if (v == null) {
      return null;
    }
    return (v as num).toDouble();
  }

  static Exoplanet fromRemote(Map<String, dynamic> exoplanet) {
    return Exoplanet(
      name: exoplanet['pl_name'] as String,
      hostName: exoplanet['hostname'] as String?,
      discYear: exoplanet['disc_year'] as int?,
      orbitalPeriod: _toDouble(exoplanet['pl_orbper']),
      radius: _toDouble(exoplanet['pl_rade']),
      mass: _toDouble(exoplanet['pl_masse']),
      temperature: _toDouble(exoplanet['pl_eqt']),
      syDistance: _toDouble(exoplanet['sy_dist']),
      discoveryMethod: exoplanet['discoverymethod'] as String?,
      stSpectype: exoplanet['st_spectype'] as String?,
    );
  }
}
