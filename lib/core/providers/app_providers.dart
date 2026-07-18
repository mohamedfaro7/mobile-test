import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/services/notification_service.dart';
import 'package:fitness_app/core/services/storage_service.dart';
import 'package:fitness_app/core/services/connectivity_service.dart';
import 'package:fitness_app/core/services/auth_service.dart';
import 'package:fitness_app/core/services/api_service.dart';
import 'package:fitness_app/core/router/app_router.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme_mode') ?? 0;
    state = ThemeMode.values[themeIndex];
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', mode.index);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale(AppConstants.defaultLanguage)) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? AppConstants.defaultLanguage;
    state = Locale(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter(ref).router;
});

final connectivityProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final storageProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final notificationProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final storage = ref.watch(storageProvider);
  return ApiService(storage);
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseMessingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final hiveBoxesProvider = FutureProvider<Map<String, Box>>((ref) async {
  final boxes = <String, Box>{};
  boxes['user'] = await Hive.openBox('user');
  boxes['settings'] = await Hive.openBox('settings');
  boxes['cache'] = await Hive.openBox('cache');
  boxes['workouts'] = await Hive.openBox('workouts');
  boxes['meals'] = await Hive.openBox('meals');
  boxes['notifications'] = await Hive.openBox('notifications');
  return boxes;
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider) != null;
});

final fcmTokenProvider = FutureProvider<String?>((ref) async {
  return await ref.watch(firebaseMessingProvider).getToken();
});

final onboardingCompletedProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_completed') ?? false;
});

final firstLaunchProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final isFirst = prefs.getBool('first_launch') ?? true;
  if (isFirst) {
    await prefs.setBool('first_launch', false);
  }
  return isFirst;
});
