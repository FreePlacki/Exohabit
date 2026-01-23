import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanets/exoplanet_extensions.dart';
import 'package:exohabit/habits/habit_remote_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'exoplanet_remote_store.g.dart';

@riverpod
ExoplanetRemoteStore exoplanetRemoteStore(Ref ref) =>
    ExoplanetRemoteStore(ref.watch(supabaseClientProvider));

class ExoplanetRemoteStore {
  ExoplanetRemoteStore(this._db);

  final SupabaseClient _db;

  static const _table = 'Exoplanets';

  Future<List<Exoplanet>> fetchAll() async {
    final response = await _db.from(_table).select();

    return response.map(ExoplanetExtensions.fromRemote).toList();
  }

  Future<Exoplanet?> fetchByName(String name) async {
    final row = await _db
        .from(_table)
        .select()
        .eq('pl_name', name)
        .maybeSingle();

    return row == null ? null : ExoplanetExtensions.fromRemote(row);
  }
}
