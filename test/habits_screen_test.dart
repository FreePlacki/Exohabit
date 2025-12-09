import 'dart:async';

import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/exoplanets/exoplanets_screen.dart';
import 'package:exohabit/habits/habits_screen.dart';
import 'package:exohabit/providers/completion_providers.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  testWidgets('renders habits and exoplanet badge', (tester) async {
    final habit = buildHabit(frequencyPerWeek: 3);
    final exoplanet = buildExoplanet();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          authStateProvider.overrideWith(
            (ref) => Stream.value(FakeUser(email: 'test@example.com', uid: 'user-1')),
          ),
          currentUserIdProvider.overrideWithValue('user-1'),
          habitsProvider.overrideWith((ref) => Stream.value([habit])),
          exoplanetsProvider.overrideWith((ref) => Stream.value([exoplanet])),
          weeklyProgressProvider.overrideWith((ref, _) => 1),
          canCompleteTodayProvider.overrideWith((ref, _) => true),
          habitCompletionsProvider.overrideWith((ref, String _) => Stream.value([])),
          habitRepositoryProvider.overrideWithValue(
            FakeHabitRepository(initialHabits: [habit]),
          ),
          rewardServiceProvider.overrideWithValue(FakeRewardService()),
        ],
        child: const MaterialApp(home: HabitsScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('Your Habits - test@example.com'), findsOneWidget);
    expect(find.text(habit.title), findsOneWidget);
    expect(find.text('1 / ${habit.frequencyPerWeek}'), findsOneWidget);
    expect(find.byIcon(Icons.rocket_launch), findsOneWidget);
  });
}

