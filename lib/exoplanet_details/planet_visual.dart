import 'package:exohabit/database.dart';
import 'package:flutter/material.dart';

class PlanetPainter extends CustomPainter {
  PlanetPainter(this.planet, {double maxRadius = 120}): _maxRadius = maxRadius;

  final Exoplanet planet;
  final double _maxRadius;

  double _planetRadiusPx(double? earthRadii) {
    if (earthRadii == null) {
      return _maxRadius / 2;
    }
    return (earthRadii * 12 * _maxRadius / 120).clamp(_maxRadius / 4, _maxRadius);
  }

  Color _temperatureToColor(double tempK) {
    return switch (tempK) {
      < 500 => const Color(0xFF2E5FFF),
      < 1000 => const Color(0xFF6FA8FF),
      < 1500 => const Color(0xFFFFC46A),
      < 2500 => const Color(0xFFFF8C42),
      _ => const Color(0xFFFF4C4C),
    };
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = _planetRadiusPx(planet.radius);

    final baseColor = _temperatureToColor(planet.temperature ?? 800);

    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 1,
        colors: [
          baseColor.withValues(alpha: 0.95),
          baseColor.withValues(alpha: 0.6),
          Colors.black,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas
      ..drawCircle(center, radius, paint)
      // Atmosphere
      ..drawCircle(
        center,
        radius + 6,
        Paint()
          ..color = baseColor.withValues(alpha: 0.15)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PlanetVisual extends StatelessWidget {
  const PlanetVisual(this.planet, {super.key});

  final Exoplanet planet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomPaint(painter: PlanetPainter(planet)),
    );
  }
}

class PhysicalParameters extends StatelessWidget {
  const PhysicalParameters(this.p, {super.key});

  final Exoplanet p;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _row('Radius', p.radius, 'R⊕'),
          _row('Mass', p.mass, 'M⊕'),
          _row('Temperature', p.temperature, 'K'),
          _row('Orbital Period', p.orbitalPeriod, 'days'),
        ],
      ),
    );
  }

  Widget _row(String label, double? value, String unit) {
    return ListTile(
      title: Text(label),
      trailing: Text(value == null ? '—' : '${value.toStringAsFixed(1)} $unit'),
    );
  }
}
