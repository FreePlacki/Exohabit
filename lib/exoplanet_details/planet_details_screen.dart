import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanet_details/planet_visual.dart';
import 'package:exohabit/exoplanets/exoplanet_repository.dart';
import 'package:exohabit/rewards/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final exoplanetProvider =
//     FutureProvider.autoDispose.family<Exoplanet?, String>((ref, id) {
//   final link = ref.keepAlive();

//   final repo = ref.read(exoplanetRepositoryProvider);
//   return repo.getFromName(id);
// });


class PlanetDetailsScreen extends ConsumerWidget {
  const PlanetDetailsScreen({super.key, required this.exoplanetName});

  final String exoplanetName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exoplanets = ref.read(exoplanetsProvider);
    return Scaffold(
      body: exoplanets.when(
        error: (err, _) =>
            Center(child: Text('Failed to load exoplanet ($err)')),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (exoplanets) {
          final exoplanet = exoplanets.where((e) => e.name == exoplanetName).first;
          return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              title: const Text('Exoplanet Details'),
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
        );}
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
          final scheme = Theme.of(context).colorScheme;
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
              _stat(context, Icons.circle_outlined, 'Radius', p.radius, 'R⊕'),
              _stat(context, Icons.scale, 'Mass', p.mass, 'M⊕'),
              _stat(
                context,
                Icons.local_fire_department,
                'Temperature',
                p.temperature,
                'K',
                accent: p.temperature != null
                    ? temperatureToColor(p.temperature!)
                    : scheme.primary,
              ),
              _stat(
                context,
                Icons.sync,
                'Orbital Period',
                p.orbitalPeriod,
                'days',
              ),
              _stat(context, Icons.public, 'Distance', p.syDistance, 'pc'),
            ],
          );
        },
      ),
    );
  }

  Widget _stat(
    BuildContext context,
    IconData icon,
    String label,
    double? value,
    String unit, {
    Color? accent,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 12),
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: scheme.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (accent ?? scheme.primary).withOpacity(0.15),
                ),
                child: Icon(icon, size: 20, color: accent ?? scheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value == null
                          ? '???'
                          : '${value.toStringAsFixed(1)} $unit',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 36,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    p.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _chip(context, Icons.star, p.hostName ?? 'Unknown star'),
                _chip(
                  context,
                  Icons.search,
                  p.discoveryMethod ?? 'Unknown method',
                ),
                if (p.discYear != null)
                  _chip(context, Icons.calendar_today, p.discYear.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, IconData icon, String text) {
    final scheme = Theme.of(context).colorScheme;

    return Chip(
      avatar: Icon(icon, size: 16, color: scheme.primary),
      label: Text(text),
    );
  }
}
