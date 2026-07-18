import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_model.freezed.dart';
part 'meal_model.g.dart';

@freezed
class MealPlan with _$MealPlan {
  const factory MealPlan({
    required String id,
    required String userId,
    required String name,
    required String description,
    required int dailyCalories,
    required MacroTargets macros,
    required List<Meal> meals,
    required DateTime startDate,
    required DateTime endDate,
    required MealPlanType type,
    required DifficultyLevel difficulty,
    List<String>? tags,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MealPlan;

  factory MealPlan.fromJson(Map<String, dynamic> json) => _$MealPlanFromJson(json);
}

@freezed
class Meal with _$Meal {
  const factory Meal({
    required String id,
    required String mealPlanId,
    required MealType type,
    required String name,
    required String description,
    required int calories,
    required MacroNutrients macros,
    required List<MealItem> items,
    required DateTime scheduledTime,
    String? instructions,
    String? imageUrl,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    DifficultyLevel? difficulty,
    List<String>? tags,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}

@freezed
class MealItem with _$MealItem {
  const factory MealItem({
    required String id,
    required String foodId,
    required String name,
    required String nameAr,
    required double quantity,
    required String unit,
    required MacroNutrients macros,
    required int calories,
    String? notes,
    @Default(false) bool isOptional,
    List<String>? alternatives,
  }) = _MealItem;

  factory MealItem.fromJson(Map<String, dynamic> json) => _$MealItemFromJson(json);
}

@freezed
class MacroTargets with _$MacroTargets {
  const factory MacroTargets({
    required double protein,
    required double carbs,
    required double fat,
    double? fiber,
    double? sugar,
    double? sodium,
  }) = _MacroTargets;

  factory MacroTargets.fromJson(Map<String, dynamic> json) => _$MacroTargetsFromJson(json);
}

@freezed
class MacroNutrients with _$MacroNutrients {
  const factory MacroNutrients({
    required double protein,
    required double carbs,
    required double fat,
    double? fiber,
    double? sugar,
    double? sodium,
    double? cholesterol,
    double? potassium,
  }) = _MacroNutrients;

  const MacroNutrients._();

  factory MacroNutrients.fromJson(Map<String, dynamic> json) => _$MacroNutrientsFromJson(json);

  int get calories => ((protein * 4) + (carbs * 4) + (fat * 9)).round();
}

@freezed
class Food with _$Food {
  const factory Food({
    required String id,
    required String name,
    required String nameAr,
    required String category,
    required MacroNutrients macrosPer100g,
    required int caloriesPer100g,
    required String servingSize,
    String? imageUrl,
    List<String>? tags,
    List<String>? allergens,
    @Default(false) bool isVerified,
    double? glycemicIndex,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}

enum MealType {
  @JsonValue('breakfast')
  breakfast,
  @JsonValue('mid_morning_snack')
  midMorningSnack,
  @JsonValue('lunch')
  lunch,
  @JsonValue('afternoon_snack')
  afternoonSnack,
  @JsonValue('dinner')
  dinner,
  @JsonValue('pre_workout')
  preWorkout,
  @JsonValue('post_workout')
  postWorkout,
  @JsonValue('before_bed')
  beforeBed,
}

enum MealPlanType {
  @JsonValue('standard')
  standard,
  @JsonValue('keto')
  keto,
  @JsonValue('vegetarian')
  vegetarian,
  @JsonValue('vegan')
  vegan,
  @JsonValue('paleo')
  paleo,
  @JsonValue('mediterranean')
  mediterranean,
  @JsonValue('intermittent_fasting')
  intermittentFasting,
  @JsonValue('high_protein')
  highProtein,
  @JsonValue('low_carb')
  lowCarb,
  @JsonValue('custom')
  custom,
}

enum DifficultyLevel {
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard,
}

extension MealTypeExtension on MealType {
  String get nameAr {
    switch (this) {
      case MealType.breakfast:
        return 'الإفطار';
      case MealType.midMorningSnack:
        return 'وجبة خفيفة منتصف الصباح';
      case MealType.lunch:
        return 'الغداء';
      case MealType.afternoonSnack:
        return 'وجبة خفيفة بعد الظهر';
      case MealType.dinner:
        return 'العشاء';
      case MealType.preWorkout:
        return 'قبل التمرين';
      case MealType.postWorkout:
        return 'بعد التمرين';
      case MealType.beforeBed:
        return 'قبل النوم';
    }
  }

  String get icon {
    switch (this) {
      case MealType.breakfast:
        return '🌅';
      case MealType.midMorningSnack:
        return '🍎';
      case MealType.lunch:
        return '🍽️';
      case MealType.afternoonSnack:
        return '🥜';
      case MealType.dinner:
        return '🌙';
      case MealType.preWorkout:
        return '⚡';
      case MealType.postWorkout:
        return '💪';
      case MealType.beforeBed:
        return '🌛';
    }
  }
}