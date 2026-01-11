import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

extension CompletionExtensions on Completion {
  static Completion create({
    required String habitId,
    required DateTime completedAt,
  }) => Completion(CompletionRow(
    id: const Uuid().v4(),
    habitId: habitId,
    completedAt: completedAt,
    updatedAt: DateTime.now(),
    deleted: false,
    synced: false,
  ));

  Map<String, dynamic> toRemote(String habitId) => {
    'id': id,
    'habitId': habitId,
    'createdAt': toTimestampString(row.completedAt.toString()),
    'updatedAt': toTimestampString(updatedAt.toString()),
    'deleted': deleted,
  };

  static Completion fromRemote(Map<String, dynamic> completion, {required bool synced}) {
    return Completion(CompletionRow(
      id: completion['id'] as String,
      habitId: completion['habitId'] as String,
      completedAt: DateTime.parse(completion['createdAt'] as String).toUtc(),
      updatedAt: DateTime.parse(completion['createdAt'] as String).toUtc(),
      deleted: completion['deleted'] as bool,
      synced: synced,
    ));
  }
}
