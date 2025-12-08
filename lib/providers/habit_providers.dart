import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/repositories/habit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final habitRepositoryProvider = Provider((ref) => HabitRepository());

/// Provides a stream of habits for the currently logged-in user.
/// Automatically updates when auth state changes - no manual invalidation needed.
final habitsProvider = StreamProvider<List<Habit>>((ref) {
  // Watch the current user ID - this automatically updates when auth changes
  final userId = ref.watch(currentUserIdProvider);
  
  // If no user is logged in, return empty stream
  if (userId == null) return const Stream.empty();

  // Watch habits for the current user
  final repo = ref.read(habitRepositoryProvider);
  return repo.watchHabits(userId);
});