import 'package:exohabit/database.dart';
import 'package:exohabit/habits/habit_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'habit_remote_store.g.dart';

@riverpod
SupabaseClient supabaseClient(Ref ref) => Supabase.instance.client;

@riverpod
HabitRemoteStore habitRemoteStore(Ref ref) =>
    SupabaseHabitRemoteStore(ref.watch(supabaseClientProvider));

abstract class HabitRemoteStore {
  Future<void> upsert(Habit habit, String userId);
  Future<void> delete(Habit habit, String userId);
  Future<List<Map<String, dynamic>>> fetch(
    String userId, {
    int sinceTimestamp = 0,
  });
  Future<List<Map<String, dynamic>>> fetchNotDeleted(
    String userId, {
    int sinceTimestamp = 0,
  });

  Future<Map<String, dynamic>?> fetchById(String habitId);
}

class SupabaseHabitRemoteStore implements HabitRemoteStore {
  SupabaseHabitRemoteStore(SupabaseClient db) : _db = db;

  final SupabaseClient _db;

  @override
  Future<void> upsert(Habit habit, String userId) async {
    await _db.from('Habits').upsert(habit.toRemote(userId));
  }

  @override
  Future<void> delete(Habit habit, String userId) =>
      _db.from('Habits').delete().eq('userId', userId).eq('id', habit.id);

  @override
  Future<List<Map<String, dynamic>>> fetch(
    String userId, {
    int sinceTimestamp = 0,
  }) => _db
      .from('Habits')
      .select()
      .eq('userId', userId)
      .gt(
        'updatedAt',
        toTimestampString(DateTime.fromMicrosecondsSinceEpoch(0).toString())!,
      );

  @override
  Future<List<Map<String, dynamic>>> fetchNotDeleted(
    String userId, {
    int sinceTimestamp = 0,
  }) => _db
      .from('Habits')
      .select()
      .eq('userId', userId)
      .eq('deleted', false)
      .gt(
        'updatedAt',
        toTimestampString(DateTime.fromMicrosecondsSinceEpoch(0).toString())!,
      );

  @override
  Future<Map<String, dynamic>?> fetchById(String habitId) =>
      _db.from('Habits').select().eq('id', habitId).maybeSingle();
}
