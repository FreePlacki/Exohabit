import 'package:exohabit/habits/habit_extensions.dart';
import 'package:exohabit/habits/habits_table.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'habit_remote_store.g.dart';

@riverpod
SupabaseClient supabaseClient(Ref ref) => Supabase.instance.client;

@riverpod
HabitRemoteStore habitRemoteStore(Ref ref) =>
    HabitRemoteStore(ref.watch(supabaseClientProvider));

class HabitRemoteStore implements RemoteSyncStore<Habit> {
  HabitRemoteStore(this._db);

  final SupabaseClient _db;

  static const _table = 'Habits';

  @override
  Future<void> upsert(Habit habit, String userId) {
    return _db.from(_table).upsert(habit.toRemote(userId));
  }

  Future<void> delete(Habit habit, String userId) {
    return _db.from(_table).delete().eq('userId', userId).eq('id', habit.id);
  }

  @override
  Future<List<Habit>> fetchAll(String userId) async {
    final rows = await _db.from(_table).select().eq('userId', userId);

    return rows
        .map((r) => HabitExtensions.fromRemote(r, synced: false))
        .toList();
  }

  @override
  Future<List<Habit>> fetchNotDeleted(String userId) async {
    final rows = await _db
        .from(_table)
        .select()
        .eq('userId', userId)
        .eq('deleted', false);

    return rows
        .map((r) => HabitExtensions.fromRemote(r, synced: false))
        .toList();
  }

  Future<Habit?> fetchById(String habitId) async {
    final row = await _db.from(_table).select().eq('id', habitId).maybeSingle();

    return row == null ? null : HabitExtensions.fromRemote(row, synced: false);
  }
}
