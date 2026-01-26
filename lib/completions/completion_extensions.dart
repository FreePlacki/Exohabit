import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

extension CompletionExtensions on Completion {
  static Completion create({required String habitId}) => Completion(
    CompletionRow(
      id: const Uuid().v4(),
      habitId: habitId,
      completedAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deleted: false,
      synced: false,
    ),
  );

  Completion markDeleted() {
    return Completion(
      CompletionRow(
        id: row.id,
        habitId: row.habitId,
        completedAt: row.completedAt,
        updatedAt: DateTime.now(),
        deleted: true,
        synced: false,
      ),
    );
  }

  Map<String, dynamic> toRemote() => {
    'id': id,
    'habitId': row.habitId,
    'createdAt': toTimestampString(row.completedAt.toString()),
    'updatedAt': toTimestampString(updatedAt.toString()),
    'deleted': deleted,
  };

  static Completion fromRemote(
    Map<String, dynamic> completion, {
    required bool synced,
  }) {
    return Completion(
      CompletionRow(
        id: completion['id'] as String,
        habitId: completion['habitId'] as String,
        completedAt: DateTime.parse(completion['createdAt'] as String).toUtc(),
        updatedAt: DateTime.parse(completion['createdAt'] as String).toUtc(),
        deleted: completion['deleted'] as bool,
        synced: synced,
      ),
    );
  }
}
