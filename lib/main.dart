import 'package:exohabit/router.dart';
import 'package:exohabit/sync/override_sync_service.dart';
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
    final router = ref.watch(routerProvider);
    ref.watch(authSyncListenerProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
    );
  }
}
