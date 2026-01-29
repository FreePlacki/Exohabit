import 'package:exohabit/database.dart';
import 'package:exohabit/exoplanets/exoplanet_repository.dart';
import 'package:exohabit/logger.dart';
import 'package:exohabit/login/auth_repository.dart';
import 'package:exohabit/router.dart';
import 'package:exohabit/sync/merge_sync_service.dart';
import 'package:exohabit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nmykcwruezxwtpxvoeth.supabase.co',
    anonKey: 'sb_publishable_As2X_jKoGUb7ggx8h-qSlQ_qmJS7Dp-',
  );

  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      child: const ExohabitApp(),
    ),
  );
}

class ExohabitApp extends ConsumerWidget {
  const ExohabitApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // pre-fetch exoplanets from remote if running for the first time
    ref.read(exoplanetRepositoryProvider).syncWithRemote();

    ref
      ..watch(syncListenerProvider)
      ..listen(authStateProvider, (prev, next) async {
        final event = next.value?.event;

        if (event == AuthChangeEvent.signedOut) {
          logger.i('Signed out, clearing local db...');
          await ref.read(databaseProvider).deleteEverything();
        }
      });

    final theme = buildExoplanetTheme();
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: theme,
      themeMode: ThemeMode.dark,
    );
  }
}
