import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/repositories/exoplanet_repository.dart';
import 'package:exohabit/repositories/habit_repository.dart';
import 'package:exohabit/services/reward_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) => FirestoreHabitRepository(),
);

final exoplanetRepositoryProvider = Provider<ExoplanetRepository>(
  (ref) => FirestoreExoplanetRepository(),
);

final rewardServiceProvider = Provider((ref) {
  final exoplanetRepo = ref.read(exoplanetRepositoryProvider);
  return RewardService(exoplanetRepo);
});

final habitsProvider = StreamProvider<List<Habit>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  
  if (userId == null) return const Stream.empty();

  final repo = ref.read(habitRepositoryProvider);
  return repo.watchHabits(userId);
});