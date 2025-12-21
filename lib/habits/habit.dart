import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'habit.freezed.dart';

@freezed
abstract class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String title,
    required String description,
    required int frequencyPerWeek,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool deleted,
    @Default(false) bool synced,
  }) = _Habit;

  factory Habit.create({
    required String title,
    required int frequencyPerWeek,
    String description = '',
  }) {
    assert(title.trim().isNotEmpty);
    assert(frequencyPerWeek > 0 && frequencyPerWeek <= 7);

    return Habit(
      id: const Uuid().v4(),
      title: title,
      description: description,
      frequencyPerWeek: frequencyPerWeek,
      createdAt: DateTime.timestamp(),
      updatedAt: DateTime.timestamp(),
    );
  }
}

extension HabitRemote on Habit {
  Map<String, dynamic> toRemote(String userId) => {
    'title': title,
    'userId': userId,
    'description': description,
    'frequencyPerWeek': frequencyPerWeek,
    'createdAt': toTimestampString(createdAt.toString()),
    'updatedAt': toTimestampString(updatedAt.toString()),
    'deleted': deleted,
  };

  static Habit fromRemote(Map<String, dynamic> habit) {
    return Habit(
      id: habit['id'] as String,
      title: habit['title'] as String,
      description: habit['description'] as String,
      frequencyPerWeek: habit['frequencyPerWeek'] as int,
      createdAt: habit['createdAt'] as DateTime,
      updatedAt: habit['updatedAt'] as DateTime,
      deleted: habit['deleted'] as bool,
    );
  }
}
