import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    String? phone,
    String? photoUrl,
    required DateTime createdAt,
    DateTime? updatedAt,
    required UserProfile profile,
    required SubscriptionInfo subscription,
    required UserStats stats,
    required UserSettings settings,
    @Default(false) bool isEmailVerified,
    @Default(true) bool isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required double height,
    required double weight,
    required int age,
    required Gender gender,
    required ActivityLevel activityLevel,
    required FitnessGoal goal,
    required List<String> dietPreferences,
    required List<String> allergies,
    required List<String> medicalConditions,
    double? targetWeight,
    double? bodyFatPercentage,
    double? muscleMass,
    Map<String, double>? measurements,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

@freezed
class SubscriptionInfo with _$SubscriptionInfo {
  const factory SubscriptionInfo({
    required SubscriptionPlan plan,
    required SubscriptionStatus status,
    required DateTime startDate,
    required DateTime endDate,
    required BillingCycle billingCycle,
    String? paymentMethodId,
    String? transactionId,
    @Default(true) bool autoRenew,
    int? membersCount,
    List<String>? memberIds,
  }) = _SubscriptionInfo;

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) => _$SubscriptionInfoFromJson(json);
}

@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    required int totalWorkouts,
    required int totalMealsLogged,
    required double totalWeightLost,
    required double totalMuscleGained,
    required int currentStreak,
    required int longestStreak,
    required double averageCaloriesPerDay,
    required double averageProteinPerDay,
    required int totalActiveDays,
    Map<String, int>? workoutsByType,
    Map<String, int>? mealsByType,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) => _$UserStatsFromJson(json);
}

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String language,
    required ThemeMode themeMode,
    required NotificationSettings notifications,
    required PrivacySettings privacy,
    required UnitsSettings units,
    @Default(false) bool showOnboarding,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);
}

enum Gender { male, female, other }

enum ActivityLevel {
  @JsonValue('sedentary')
  sedentary,
  @JsonValue('light')
  light,
  @JsonValue('moderate')
  moderate,
  @JsonValue('active')
  active,
  @JsonValue('very_active')
  veryActive,
}

enum FitnessGoal {
  @JsonValue('lose_weight')
  loseWeight,
  @JsonValue('build_muscle')
  buildMuscle,
  @JsonValue('maintain_weight')
  maintainWeight,
  @JsonValue('improve_fitness')
  improveFitness,
  @JsonValue('increase_strength')
  increaseStrength,
  @JsonValue('improve_flexibility')
  improveFlexibility,
}

enum SubscriptionPlan {
  @JsonValue('individual')
  individual,
  @JsonValue('family')
  family,
  @JsonValue('corporate')
  corporate,
}

enum SubscriptionStatus {
  @JsonValue('active')
  active,
  @JsonValue('expired')
  expired,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('pending')
  pending,
  @JsonValue('trial')
  trial,
}

enum BillingCycle {
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
}

enum ThemeMode {
  @JsonValue('light')
  light,
  @JsonValue('dark')
  dark,
  @JsonValue('system')
  system,
}

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @Default(true) bool enabled,
    @Default(true) bool mealReminders,
    @Default(true) bool workoutReminders,
    @Default(true) bool waterReminders,
    @Default(true) bool progressReminders,
    @Default(false) bool promotional,
    String? sound,
    @Default(true) bool vibration,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => _$NotificationSettingsFromJson(json);
}

@freezed
class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    @Default(true) bool shareProgress,
    @Default(false) bool showInLeaderboard,
    @Default(true) bool allowFriendRequests,
    @Default(true) bool dataCollection,
    @Default(false) bool analytics,
  }) = _PrivacySettings;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) => _$PrivacySettingsFromJson(json);
}

@freezed
class UnitsSettings with _$UnitsSettings {
  const factory UnitsSettings({
    @Default('metric') String weightUnit,
    @Default('metric') String heightUnit,
    @Default('metric') String distanceUnit,
    @Default('celsius') String temperatureUnit,
  }) = _UnitsSettings;

  factory UnitsSettings.fromJson(Map<String, dynamic> json) => _$UnitsSettingsFromJson(json);
}