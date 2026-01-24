import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanet_details/planet_visual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanetDetailsScreen extends ConsumerWidget {
  const PlanetDetailsScreen({super.key, required this.exoplanet});

  final Exoplanet exoplanet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            title: Text(exoplanet.name),
            flexibleSpace: FlexibleSpaceBar(
              background: PlanetVisual(exoplanet),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              PlanetSummary(exoplanet),
              const SizedBox(height: 8),
              PhysicalParameters(exoplanet),
              const SizedBox(height: 24),
            ]),
          ),
        ],
      ),
    );
  }
}

class PhysicalParameters extends StatelessWidget {
  const PhysicalParameters(this.p, {super.key});
  final Exoplanet p;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final colorScheme = Theme.of(context).colorScheme;
          return GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 260,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.4,
            ),
            children: [
              _stat(colorScheme, Icons.circle_outlined, 'Radius', p.radius, 'R⊕'),
              _stat(colorScheme, Icons.scale, 'Mass', p.mass, 'M⊕'),
              _stat(colorScheme, Icons.local_fire_department, 'Temperature', p.temperature, 'K'),
              _stat(colorScheme, Icons.sync, 'Orbital Period', p.orbitalPeriod, 'days'),
              if (p.syDistance != null)
                _stat(colorScheme, Icons.public, 'Distance', p.syDistance, 'pc'),
            ],
          );
        },
      ),
    );
  }

  Widget _stat(ColorScheme colorScheme, IconData icon, String label, double? value, String unit) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value == null ? '???' : '${value.toStringAsFixed(1)} $unit',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanetSummary extends StatelessWidget {
  const PlanetSummary(this.p, {super.key});
  final Exoplanet p;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              p.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _chip(Icons.star, p.hostName ?? 'Unknown star'),
                _chip(Icons.search, p.discoveryMethod ?? 'Unknown method'),
                if (p.discYear != null)
                  _chip(Icons.calendar_today, p.discYear.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(text),
    );
  }
}
