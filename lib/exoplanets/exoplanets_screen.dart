import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/models/exoplanet.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exoplanetsProvider = StreamProvider<List<Exoplanet>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) {
    return const Stream.empty();
  }

  final repo = ref.read(exoplanetRepositoryProvider);
  return repo.watchExoplanets(userId);
});

class ExoplanetsScreen extends ConsumerWidget {
  const ExoplanetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exoplanets = ref.watch(exoplanetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Exoplanets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh planet cache',
            onPressed: () async {
              try {
                final repo = ref.read(exoplanetRepositoryProvider);
                await repo.refreshCache();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Planet cache refreshed!')),
                  );
                }
              } catch (err) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to refresh cache: $err')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: exoplanets.when(
        data: (list) {
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.rocket_launch_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No exoplanets discovered yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complete habits to discover exoplanets!',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final exoplanet = list[index];
              return _ExoplanetCard(exoplanet: exoplanet);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading exoplanets: $e'),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExoplanetCard extends StatelessWidget {
  const _ExoplanetCard({required this.exoplanet});
  final Exoplanet exoplanet;

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => _showPlanetDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Planet icon with temperature-based color
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: _getPlanetColors(),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.public, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exoplanet.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Discovered: ${_formatDate(exoplanet.discoveryDate)}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    if (exoplanet.hostname != null &&
                        exoplanet.hostname!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Host star: ${exoplanet.hostname}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                    const SizedBox(height: 4),
                    _buildPlanetStats(),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getPlanetColors() {
    // Color based on equilibrium temperature (if available)
    if (exoplanet.equilibriumTemperature != null) {
      final temp = exoplanet.equilibriumTemperature!;
      if (temp < 273) {
        return [Colors.blue.shade400, Colors.cyan.shade400]; // Cold
      }
      if (temp < 373) {
        return [Colors.green.shade400, Colors.teal.shade400]; // Temperate
      }
      if (temp < 1000) {
        return [Colors.orange.shade400, Colors.red.shade400]; // Hot
      }
      return [Colors.red.shade600, Colors.purple.shade600]; // Very hot
    }
    return [Colors.blue.shade400, Colors.purple.shade400]; // Default
  }

  Widget _buildPlanetStats() {
    final stats = <String>[];

    if (exoplanet.planetRadius != null) {
      stats.add('${exoplanet.planetRadius!.toStringAsFixed(1)} R⊕');
    }
    if (exoplanet.planetMass != null) {
      stats.add('${exoplanet.planetMass!.toStringAsFixed(1)} M⊕');
    }
    if (exoplanet.orbitalPeriod != null) {
      stats.add('${exoplanet.orbitalPeriod!.toStringAsFixed(1)} days');
    }
    if (exoplanet.equilibriumTemperature != null) {
      stats.add('${exoplanet.equilibriumTemperature!.toInt()} K');
    }

    if (stats.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: stats
          .map(
            (stat) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                stat,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void _showPlanetDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: _getPlanetColors(),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        Icons.public,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exoplanet.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (exoplanet.hostname != null &&
                              exoplanet.hostname!.isNotEmpty)
                            Text(
                              exoplanet.hostname!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Discovery info
                _buildDetailSection('Discovery', [
                  if (exoplanet.discoveryMethod != null)
                    _buildDetailRow('Method', exoplanet.discoveryMethod!),
                  if (exoplanet.discoveryYear != null)
                    _buildDetailRow(
                      'Year',
                      exoplanet.discoveryYear!.toString(),
                    ),
                  _buildDetailRow(
                    'Earned',
                    _formatDate(exoplanet.discoveryDate),
                  ),
                ]),

                // Physical properties
                if (exoplanet.planetRadius != null ||
                    exoplanet.planetMass != null ||
                    exoplanet.equilibriumTemperature != null)
                  _buildDetailSection('Physical Properties', [
                    if (exoplanet.planetRadius != null)
                      _buildDetailRow(
                        'Radius',
                        '${exoplanet.planetRadius!.toStringAsFixed(2)} Earth radii',
                      ),
                    if (exoplanet.planetMass != null)
                      _buildDetailRow(
                        'Mass',
                        '${exoplanet.planetMass!.toStringAsFixed(2)} Earth masses',
                      ),
                    if (exoplanet.equilibriumTemperature != null)
                      _buildDetailRow(
                        'Temperature',
                        '${exoplanet.equilibriumTemperature!.toInt()} K',
                      ),
                  ]),

                // Orbital properties
                if (exoplanet.orbitalPeriod != null ||
                    exoplanet.distance != null)
                  _buildDetailSection('Orbital Properties', [
                    if (exoplanet.orbitalPeriod != null)
                      _buildDetailRow(
                        'Orbital Period',
                        '${exoplanet.orbitalPeriod!.toStringAsFixed(1)} days',
                      ),
                    if (exoplanet.distance != null)
                      _buildDetailRow(
                        'Distance',
                        '${exoplanet.distance!.toStringAsFixed(1)} parsecs',
                      ),
                  ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
        const Divider(height: 24),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
