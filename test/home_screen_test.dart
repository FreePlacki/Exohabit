import 'package:exohabit/exoplanets/exoplanets_screen.dart';
import 'package:exohabit/home/home_screen.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/providers/completion_providers.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:exohabit/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  testWidgets('home screen shows stats, calendar, exoplanet highlight and quick actions', (tester) async {
    final habit = buildHabit();
    final stats = HomeStats(
      todayCount: 1,
      weekCount: 3,
      weekGoal: 5,
      streakDays: 4,
      weekdayCounts: [1, 1, 0, 0, 1, 0, 0],
      habitsCount: 2,
    );
    final exoplanet = buildExoplanet(name: 'Kepler-99b');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          authStateProvider.overrideWith((ref) => Stream.value(FakeUser(email: 'astro@demo.com', uid: 'user-1'))),
          currentUserIdProvider.overrideWithValue('user-1'),
          homeStatsProvider.overrideWithValue(AsyncData(stats)),
          habitsProvider.overrideWith((ref) => Stream.value([habit])),
          canCompleteTodayProvider.overrideWith((ref, _) => true),
          habitCompletionsProvider.overrideWith((ref, String _) => Stream.value([])),
          habitRepositoryProvider.overrideWithValue(FakeHabitRepository(initialHabits: [habit])),
          rewardServiceProvider.overrideWithValue(FakeRewardService()),
          exoplanetsProvider.overrideWith((ref) => Stream.value([exoplanet])),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.textContaining('Welcome back'), findsOneWidget);
    expect(find.text('astro@demo.com'), findsOneWidget);
    expect(find.textContaining('streak'), findsOneWidget);
    expect(find.text('Today\'s habits'), findsOneWidget);
    expect(find.text(habit.title), findsOneWidget);
    expect(find.textContaining('Kepler-99b'), findsOneWidget);
    expect(find.textContaining('unlocked'), findsOneWidget);
    expect(find.text('Add habit'), findsOneWidget);
    expect(find.text('Exoplanets'), findsOneWidget);
  });
}

