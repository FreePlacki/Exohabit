import 'dart:async';

import 'package:exohabit/auth/auth_providers.dart';
import 'package:exohabit/models/habit.dart';
import 'package:exohabit/providers/habit_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  test('habitsProvider emits habits from the repository stream', () async {
    final habit = buildHabit();
    final container = ProviderContainer(
      overrides: [
        currentUserIdProvider.overrideWithValue('user-1'),
        habitRepositoryProvider.overrideWithValue(
          FakeHabitRepository(initialHabits: [habit]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final completer = Completer<List<Habit>>();
    final sub = container.listen<AsyncValue<List<Habit>>>(
      habitsProvider,
      (previous, next) {
        if (next.hasValue && !completer.isCompleted) {
          completer.complete(next.requireValue);
        }
      },
      fireImmediately: true,
    );

    final result = await completer.future;
    sub.close();

    expect(result, isNotEmpty);
    expect(result.first.title, habit.title);
  });
}

