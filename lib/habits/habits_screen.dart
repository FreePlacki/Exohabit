import 'package:exohabit/auth/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/habit_providers.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final habits = ref.watch(habitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Habits"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authRepo.signOut();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/create-habit');
        },
        child: const Icon(Icons.add),
      ),
      body: habits.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text("No habits yet."));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final h = list[i];
              return ListTile(
                title: Text(h.title),
                subtitle: Text(h.description),
                trailing: Text("${h.frequencyPerWeek}x / week"),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
