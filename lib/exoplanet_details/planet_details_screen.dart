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
      appBar: AppBar(title: Text(exoplanet.name)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: PlanetVisual(exoplanet)),
          SliverList(
            delegate: SliverChildListDelegate([
              // PlanetSummary(exoplanet),
              PhysicalParameters(exoplanet),
              // StellarParameters(exoplanet),
            ]),
          ),
        ],
      ),
    );
  }
}
