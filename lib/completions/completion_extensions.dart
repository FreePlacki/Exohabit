import 'package:exohabit/database.dart';
import 'package:uuid/uuid.dart';

extension CompletionExtensions on Completion {
  static Completion create({
    required String habitId,
    required DateTime completedAt,
  }) => Completion(
    id: const Uuid().v4(),
    habitId: habitId,
    completedAt: completedAt,
    updatedAt: DateTime.now(),
    deleted: false,
    synced: false,
  );
}
