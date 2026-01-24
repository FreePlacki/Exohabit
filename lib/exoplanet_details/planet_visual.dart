import 'package:exohabit/database.dart';
import 'package:flutter/material.dart';

Color temperatureToColor(double tempK) {
  return switch (tempK) {
    < 500 => const Color(0xFF2E5FFF),
    < 1000 => const Color(0xFF6FA8FF),
    < 1500 => const Color(0xFFFFC46A),
    < 2000 => const Color(0xFFFF8C42),
    _ => const Color(0xFFFF4C4C),
  };
}

class PlanetPainter extends CustomPainter {
  PlanetPainter(this.planet, {double maxRadius = 120}) : _maxRadius = maxRadius;

  final Exoplanet planet;
  final double _maxRadius;

  double _planetRadiusPx(double? earthRadii) {
    if (earthRadii == null) {
      return _maxRadius / 2;
    }
    return (earthRadii * _maxRadius * 0.2).clamp(_maxRadius / 4, _maxRadius);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = _planetRadiusPx(planet.radius);

    final baseColor = temperatureToColor(planet.temperature ?? 800);

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

class PlanetVisual extends StatefulWidget {
  const PlanetVisual(this.planet, {super.key});
  final Exoplanet planet;

  @override
  State<PlanetVisual> createState() => _PlanetVisualState();
}

class _PlanetVisualState extends State<PlanetVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  )..forward();

  late final Animation<double> _scale = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutBack,
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  Widget build(BuildContext context) {
    final color = temperatureToColor(widget.planet.temperature ?? 800);

    return Container(
      height: 320,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.6),
          radius: 1.2,
          colors: [color.withValues(alpha: 0.25), Theme.of(context).colorScheme.surface],
        ),
      ),
      child: FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: CustomPaint(painter: PlanetPainter(widget.planet)),
        ),
      ),
    );
  }
}
