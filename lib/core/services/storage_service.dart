import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  late Box _userBox;
  late Box _settingsBox;
  late Box _cacheBox;
  late Box _workoutsBox;
  late Box _mealsBox;
  late Box _notificationsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox('user');
    _settingsBox = await Hive.openBox('settings');
    _cacheBox = await Hive.openBox('cache');
    _workoutsBox = await Hive.openBox('workouts');
    _mealsBox = await Hive.openBox('meals');
    _notificationsBox = await Hive.openBox('notifications');
  }

  Future<void> saveUserData(Map<String, dynamic> data) async {
    await _userBox.put('profile', data);
    await _userBox.put('last_sync', DateTime.now().toIso8601String());
  }

  Map<String, dynamic>? getUserData() {
    return _userBox.get('profile') as Map<String, dynamic>?;
  }

  Future<void> clearUserData() async {
    await _userBox.delete('profile');
    await _userBox.delete('token');
    await _userBox.delete('refresh_token');
  }

  Future<void> saveToken(String token) async {
    await _userBox.put('token', token);
  }

  String? getToken() {
    return _userBox.get('token') as String?;
  }

  Future<void> saveRefreshToken(String token) async {
    await _userBox.put('refresh_token', token);
  }

  String? getRefreshToken() {
    return _userBox.get('refresh_token') as String?;
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    await _settingsBox.putAll(settings);
  }

  T? getSetting<T>(String key, {T? defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue) as T?;
  }

  Future<void> setSetting<T>(String key, T value) async {
    await _settingsBox.put(key, value);
  }

  Future<void> cacheData(String key, dynamic data, {Duration? expiration}) async {
    final cacheItem = CacheItem(
      data: data,
      timestamp: DateTime.now(),
      expiration: expiration ?? const Duration(days: 7),
    );
    await _cacheBox.put(key, jsonEncode(cacheItem.toJson()));
  }

  T? getCachedData<T>(String key) {
    final json = _cacheBox.get(key) as String?;
    if (json == null) return null;

    try {
      final item = CacheItem.fromJson(jsonDecode(json) as Map<String, dynamic>);
      if (item.isExpired) {
        _cacheBox.delete(key);
        return null;
      }
      return item.data as T?;
    } catch (e) {
      _cacheBox.delete(key);
      return null;
    }
  }

  Future<void> clearCache({String? key}) async {
    if (key != null) {
      await _cacheBox.delete(key);
    } else {
      await _cacheBox.clear();
    }
  }

  Future<void> saveWorkout(Map<String, dynamic> workout) async {
    final id = workout['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString();
    await _workoutsBox.put(id, workout);
  }

  Map<String, dynamic>? getWorkout(String id) {
    return _workoutsBox.get(id) as Map<String, dynamic>?;
  }

  List<Map<String, dynamic>> getAllWorkouts() {
    return _workoutsBox.values.cast<Map<String, dynamic>>().toList();
  }

  Future<void> deleteWorkout(String id) async {
    await _workoutsBox.delete(id);
  }

  Future<void> saveMeal(Map<String, dynamic> meal) async {
    final id = meal['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString();
    await _mealsBox.put(id, meal);
  }

  Map<String, dynamic>? getMeal(String id) {
    return _mealsBox.get(id) as Map<String, dynamic>?;
  }

  List<Map<String, dynamic>> getAllMeals() {
    return _mealsBox.values.cast<Map<String, dynamic>>().toList();
  }

  Future<void> deleteMeal(String id) async {
    await _mealsBox.delete(id);
  }

  Future<void> saveNotification(Map<String, dynamic> notification) async {
    final id = notification['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString();
    await _notificationsBox.put(id, notification);
  }

  List<Map<String, dynamic>> getNotifications({int limit = 50}) {
    final notifications = _notificationsBox.values.cast<Map<String, dynamic>>().toList();
    notifications.sort((a, b) {
      final aTime = DateTime.tryParse((a['timestamp'] as String?) ?? '') ?? DateTime.now();
      final bTime = DateTime.tryParse((b['timestamp'] as String?) ?? '') ?? DateTime.now();
      return bTime.compareTo(aTime);
    });
    return notifications.take(limit).toList();
  }

  Future<void> markNotificationRead(String id) async {
    final notification = _notificationsBox.get(id) as Map<String, dynamic>?;
    if (notification != null) {
      notification['read'] = true;
      await _notificationsBox.put(id, notification);
    }
  }

  Future<void> saveOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
  }

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') ?? false;
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', mode.index);
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return ThemeMode.values[prefs.getInt('theme_mode') ?? 0];
  }

  Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language_code') ?? 'ar';
  }

  Future<void> clearAll() async {
    await _userBox.clear();
    await _settingsBox.clear();
    await _cacheBox.clear();
    await _workoutsBox.clear();
    await _mealsBox.clear();
    await _notificationsBox.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

class CacheItem {
  final dynamic data;
  final DateTime timestamp;
  final Duration expiration;

  CacheItem({required this.data, required this.timestamp, required this.expiration});

  bool get isExpired => DateTime.now().difference(timestamp) > expiration;

  Map<String, dynamic> toJson() => {
    'data': data,
    'timestamp': timestamp.toIso8601String(),
    'expiration': expiration.inMilliseconds,
  };

  factory CacheItem.fromJson(Map<String, dynamic> json) => CacheItem(
    data: json['data'],
    timestamp: DateTime.parse(json['timestamp'] as String),
    expiration: Duration(milliseconds: json['expiration'] as int),
  );
}
