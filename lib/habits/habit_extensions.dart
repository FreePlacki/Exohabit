import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

extension HabitExtensions on Habit {
  static Habit createHabit({
    required String title,
    required int frequencyPerWeek,
    String description = '',
  }) {
    assert(title.trim().isNotEmpty);
    assert(frequencyPerWeek > 0 && frequencyPerWeek <= 7);

    return Habit(
      HabitRow(
        id: const Uuid().v4(),
        title: title,
        description: description,
        frequencyPerWeek: frequencyPerWeek,
        createdAt: DateTime.timestamp(),
        updatedAt: DateTime.timestamp(),
        deleted: false,
        synced: false,
      ),
    );
  }

  Map<String, dynamic> toRemote(String userId) => {
    'id': id,
    'title': row.title,
    'userId': userId,
    'description': row.description,
    'frequencyPerWeek': row.frequencyPerWeek,
    'createdAt': toTimestampString(row.createdAt.toString()),
    'updatedAt': toTimestampString(updatedAt.toString()),
    'deleted': deleted,
  };

  static Habit fromRemote(Map<String, dynamic> habit, {required bool synced}) {
    return Habit(HabitRow(
      id: habit['id'] as String,
      title: habit['title'] as String,
      description: habit['description'] as String,
      frequencyPerWeek: habit['frequencyPerWeek'] as int,
      createdAt: DateTime.parse(habit['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(habit['createdAt'] as String).toUtc(),
      deleted: habit['deleted'] as bool,
      synced: synced,
    ));
  }
}
