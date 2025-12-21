import 'package:exohabit/habits/habit.dart';
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
  Future<List<Habit>> fetchUpdatedSince(String userId, int sinceTimestamp);
}

class SupabaseHabitRemoteStore implements HabitRemoteStore {
  SupabaseHabitRemoteStore(SupabaseClient db) : _db = db;

  final SupabaseClient _db;

  @override
  Future<void> upsert(Habit habit, String userId) async {
    await _db.from('habits').upsert(habit.toRemote(userId));
  }

  @override
  Future<void> delete(Habit habit, String userId) =>
      _db.from('habits').delete().eq('userId', userId).eq('id', habit.id);

  @override
  Future<List<Habit>> fetchUpdatedSince(
    String userId,
    int sinceTimestamp,
  ) async {
    final rows = await _db
        .from('habits')
        .select()
        .eq('user_id', userId)
        .gt('updated_at', sinceTimestamp);

    return rows.map(HabitRemote.fromRemote).toList();
  }
}
