import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/repositories/habit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final habitRepositoryProvider = Provider((ref) => HabitRepository());

final habitsProvider = StreamProvider<List<Habit>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) return const Stream.empty();

  final repo = ref.read(habitRepositoryProvider);
  return repo.watchHabits(userId);
});