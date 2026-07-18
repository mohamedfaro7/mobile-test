import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/core/router/app_router.dart';
import 'package:fitness_app/core/services/storage_service.dart';
import 'package:fitness_app/core/services/notification_service.dart';
import 'package:fitness_app/core/services/connectivity_service.dart';
import 'package:fitness_app/core/providers/app_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  await NotificationService().initialize();
  ConnectivityService();

  runApp(
    const ProviderScope(
      child: FitnessApp(),
    ),
  );
}

class FitnessApp extends ConsumerWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppConstants.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
