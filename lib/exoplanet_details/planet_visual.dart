import 'dart:math' as math;

import 'package:exohabit/database.dart';
import 'package:flutter/material.dart';

Color temperatureToColor(double tempK) {
  const minT = 400.0;
  const maxT = 2000.0;

  final t = ((tempK - minT) / (maxT - minT)).clamp(0.0, 1.0);

  const colors = [
    Color(0xFF2E5FFF),
    Color(0xFF6FA8FF),
    Color(0xFFFFD27D),
    Color(0xFFFF8C42),
    Color(0xFFFF4C4C),
  ];

  final scaled = t * (colors.length - 1);
  final i = scaled.floor();
  final frac = scaled - i;

  if (i >= colors.length - 1) {
    return colors.last;
  }
  return Color.lerp(colors[i], colors[i + 1], frac)!;
}

class PlanetPainter extends CustomPainter {
  PlanetPainter(
    this.planet, {
    required double? rotation,
    double maxRadius = 120,
  }) : _maxRadius = maxRadius,
       _rotation = rotation ?? 0.1;

  final Exoplanet planet;
  final double _rotation;
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

    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..rotate(_rotation)
      ..translate(-center.dx, -center.dy);

    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.4, -0.4),
        radius: 1,
        colors: [
          baseColor.withValues(alpha: 0.95),
          baseColor.withValues(alpha: 0.6),
          Colors.black,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas
      ..drawCircle(center, radius, paint)
      ..drawCircle(
        center,
        radius + 6,
        Paint()
          ..color = baseColor.withValues(alpha: 0.18)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(covariant PlanetPainter oldDelegate) {
    return oldDelegate._rotation != _rotation || oldDelegate.planet != planet;
  }
}

class PlanetVisual extends StatefulWidget {
  const PlanetVisual(this.planet, {super.key});
  final Exoplanet planet;

  @override
  State<PlanetVisual> createState() => _PlanetVisualState();
}

class _PlanetVisualState extends State<PlanetVisual>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _rotationController;

  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    final periodDays = widget.planet.orbitalPeriod ?? 100;
    final secondsPerRotation = (periodDays * 1.5).clamp(6.0, 50.0);

    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (secondsPerRotation * 1000).round()),
    )..repeat();

    _scale = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutBack,
    );

    _fade = CurvedAnimation(parent: _introController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _introController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = temperatureToColor(widget.planet.temperature ?? 800);

    return Container(
      height: 320,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.6),
          radius: 1.2,
          colors: [
            color.withValues(alpha: 0.25),
            Theme.of(context).colorScheme.surface,
          ],
        ),
      ),
      child: FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, _) {
              return CustomPaint(
                painter: PlanetPainter(
                  widget.planet,
                  rotation: _rotationController.value * 2 * math.pi,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
