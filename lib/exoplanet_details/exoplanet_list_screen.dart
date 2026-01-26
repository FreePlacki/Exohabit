import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanet_details/planet_visual.dart';
import 'package:exohabit/rewards/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExoplanetListScreen extends ConsumerWidget {
  const ExoplanetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exoplanets = ref.watch(unlockedExoplanetsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Exoplanets')),
      body: exoplanets.when(
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (planets) => planets.isEmpty
            ? const Center(child: Text('Complete habits to unlock exoplanets.'))
            : ListView.separated(
                itemCount: planets.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ExoplanetListTile(planets[index]);
                },
              ),
      ),
    );
  }
}

class ExoplanetListTile extends StatelessWidget {
  const ExoplanetListTile(this.planet, {super.key});

  final Exoplanet planet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(12),
      child: ListTile(
        dense: false,
        leading: PlanetMiniature(planet),
        title: Text(planet.name),
        subtitle: _subtitle(),
        onTap: () => context.push('/exoplanet-details/${planet.name}'),
      ),
    );
  }

  Widget _subtitle() {
    final parts = <String>[];
    if (planet.hostName != null) {
      parts.add(planet.hostName!);
    }
    if (planet.discoveryMethod != null) {
      parts.add(planet.discoveryMethod!);
    }

    return Text(parts.join(' • '));
  }
}

class PlanetMiniature extends StatelessWidget {
  const PlanetMiniature(this.planet, {this.size = 40, super.key});

  final Exoplanet planet;
  final double size;

  @override
  Widget build(BuildContext context) {
    final rotation = planet.orbitalPeriod != null
        ? 1 / planet.orbitalPeriod! * 0.1
        : 0.1;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: PlanetPainter(planet, maxRadius: size, rotation: rotation),
      ),
    );
  }
}
