import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/repositories/exoplanet_repository.dart';
import 'package:exohabit/repositories/habit_repository.dart';
import 'package:exohabit/services/exoplanet_api_service.dart';
import 'package:exohabit/services/reward_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) => FirestoreHabitRepository(),
);

final exoplanetRepositoryProvider = Provider<ExoplanetRepository>(
  (ref) => FirestoreExoplanetRepository(),
);

final exoplanetApiServiceProvider = Provider<ExoplanetApiService>(
  (ref) => ExoplanetApiService(),
);

// Manual cache refresh trigger (useful for admin/debug)
final refreshExoplanetCacheProvider = FutureProvider<void>((ref) async {
  final repo = ref.read(exoplanetRepositoryProvider);
  await repo.refreshCache();
});

// Initialize exoplanet cache on app start (only when authenticated)
final initializeExoplanetCacheProvider = FutureProvider<void>((ref) async {
  final authState = ref.watch(authStateProvider);
  if (authState.value == null) return;

  try {
    final repo = ref.read(exoplanetRepositoryProvider);
    final shouldRefresh = await Future.any([
      repo.shouldRefreshCache(),
      Future.delayed(const Duration(seconds: 5), () => false),
    ]);

    if (shouldRefresh) {
      await Future.any([
        repo.refreshCache(),
        Future.delayed(const Duration(seconds: 10), () => null),
      ]);
    }
  } catch (_) {
    // Silently fail - cache will be refreshed next time
  }
});

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