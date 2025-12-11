import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  late FakeHabitRepository fakeRepo;

  setUp(() {
    fakeRepo = FakeHabitRepository();
  });

  test('can create and record completion', () async {
    final habit = buildHabit();
    await fakeRepo.createHabit(habit, 'user-1');

    final completionId = await fakeRepo.recordCompletion(habit.id, 'user-1', DateTime.now());
    expect(completionId, isNotEmpty);

    final completions = await fakeRepo.getCompletionsForHabit(habit.id, 'user-1').first;
    expect(completions.length, 1);
    expect(completions.first.habitId, habit.id);
  });
}
