import 'package:exohabit/completions/completion_extensions.dart';
import 'package:exohabit/completions/completions_table.dart';
import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:exohabit/sync/sync_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'completion_remote_store.g.dart';

@riverpod
CompletionRemoteStore completionRemoteStore(Ref ref) =>
    CompletionRemoteStore(ref.watch(supabaseClientProvider));

class CompletionRemoteStore implements RemoteSyncStore<Completion> {
  CompletionRemoteStore(this._db);

  final SupabaseClient _db;

  static const _table = 'Completions';

  @override
  Future<void> upsert(Completion completion, String userId) {
    return _db.from(_table).upsert(completion.toRemote());
  }

  Future<void> delete(Completion completion) {
    return _db.from(_table).delete().eq('id', completion.id);
  }

  @override
  Future<List<Completion>> fetchAll(String userId) async {
    final response = await _db
        .from(_table)
        .select('*, Habits!inner(id)')
        .eq('Habits.userId', userId);

    return response
        .map((row) => CompletionExtensions.fromRemote(row, synced: false))
        .toList();
  }

  @override
  Future<List<Completion>> fetchNotDeleted(String userId) async {
    final rows = await _db.from(_table).select().eq('deleted', false);

    return rows
        .map((r) => CompletionExtensions.fromRemote(r, synced: false))
        .toList();
  }

  Future<Completion?> fetchById(String completionId) async {
    final row = await _db
        .from(_table)
        .select()
        .eq('id', completionId)
        .maybeSingle();

    return row == null
        ? null
        : CompletionExtensions.fromRemote(row, synced: false);
  }
}
