import 'package:exohabit/habits/habit_controller.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);
    final user = ref.watch(currentUserProvider);
    final email = user?.email ?? 'Signed Out';

    final habits = ref.watch(habitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exohabit ($email)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authRepo.signOut();
              if (context.mounted) {
                context.go('/auth');
              }
            },
          ),
        ],
      ),
      body: habits.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (buildContext, i) {
            final habit = data[i];
            return Text(habit.title);
          },
        ),
        error: (err, st) => Center(child: Text('Error loading habits ($err)')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          context.push('/habits');
        },
      ),
    );
  }
}
