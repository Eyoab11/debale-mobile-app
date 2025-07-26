import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:debale/core/theme/app_theme.dart';
import 'package:debale/core/routing/app_router.dart';

class DebaleApp extends ConsumerWidget {
  const DebaleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Debale',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: const [
        // Add localization delegates here
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('am', 'ET'), // Amharic
        Locale('om', 'ET'), // Oromo
      ],
    );
  }
} 