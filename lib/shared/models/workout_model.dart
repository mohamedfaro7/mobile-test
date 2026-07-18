import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_model.freezed.dart';
part 'workout_model.g.dart';

@freezed
class WorkoutPlan with _$WorkoutPlan {
  const factory WorkoutPlan({
    required String id,
    required String userId,
    required String name,
    required String nameAr,
    required String description,
    required String descriptionAr,
    required int weeks,
    required int daysPerWeek,
    required int sessionDurationMinutes,
    required DifficultyLevel difficulty,
    required WorkoutGoal goal,
    required List<WorkoutDay> days,
    required List<String> requiredEquipment,
    List<String>? tags,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalCaloriesBurn,
    WorkoutPlanStats? stats,
  }) = _WorkoutPlan;

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => _$WorkoutPlanFromJson(json);
}

@freezed
class WorkoutDay with _$WorkoutDay {
  const factory WorkoutDay({
    required int dayNumber,
    required String name,
    required String nameAr,
    required String focus,
    required String focusAr,
    required List<WorkoutExercise> exercises,
    required int estimatedDurationMinutes,
    required int estimatedCaloriesBurn,
    @Default(false) bool isRestDay,
    String? notes,
    String? notesAr,
  }) = _WorkoutDay;

  factory WorkoutDay.fromJson(Map<String, dynamic> json) => _$WorkoutDayFromJson(json);
}

@freezed
class WorkoutExercise with _$WorkoutExercise {
  const factory WorkoutExercise({
    required String id,
    required String exerciseId,
    required String name,
    required String nameAr,
    required String description,
    required String descriptionAr,
    required MuscleGroup primaryMuscle,
    required List<MuscleGroup> secondaryMuscles,
    required ExerciseType type,
    required DifficultyLevel difficulty,
    required int sets,
    required RepsScheme reps,
    required RestPeriod rest,
    required double? weight,
    required String? weightUnit,
    String? videoUrl,
    String? thumbnailUrl,
    List<String>? instructions,
    List<String>? instructionsAr,
    List<String>? tips,
    List<String>? tipsAr,
    List<String>? commonMistakes,
    List<String>? commonMistakesAr,
    List<String>? alternatives,
    int? rpe,
    double? tempo,
    @Default(false) bool isSuperset,
    int? supersetGroup,
    @Default(false) bool isWarmup,
    @Default(false) bool isCooldown,
  }) = _WorkoutExercise;

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) => _$WorkoutExerciseFromJson(json);
}

@freezed
class RepsScheme with _$RepsScheme {
  const factory RepsScheme.fixed({
    required int reps,
  }) = FixedReps;

  const factory RepsScheme.range({
    required int min,
    required int max,
  }) = RangeReps;

  const factory RepsScheme.amrap({
    required int target,
  }) = AmrapReps;

  const factory RepsScheme.pyramid({
    required List<int> reps,
  }) = PyramidReps;

  const factory RepsScheme.dropSet({
    required int initialReps,
    required int drops,
  }) = DropSetReps;

  factory RepsScheme.fromJson(Map<String, dynamic> json) => _$RepsSchemeFromJson(json);
}

@freezed
class RestPeriod with _$RestPeriod {
  const factory RestPeriod.fixed({
    required int seconds,
  }) = FixedRest;

  const factory RestPeriod.range({
    required int minSeconds,
    required int maxSeconds,
  }) = RangeRest;

  const factory RestPeriod.untilReady() = UntilReadyRest;

  factory RestPeriod.fromJson(Map<String, dynamic> json) => _$RestPeriodFromJson(json);
}

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    required String nameAr,
    required String description,
    required String descriptionAr,
    required MuscleGroup primaryMuscle,
    required List<MuscleGroup> secondaryMuscles,
    required ExerciseType type,
    required DifficultyLevel difficulty,
    required List<String> equipment,
    required String? videoUrl,
    required String? thumbnailUrl,
    required List<String> instructions,
    required List<String> instructionsAr,
    required List<String> tips,
    required List<String> tipsAr,
    required List<String> commonMistakes,
    required List<String> commonMistakesAr,
    required List<String> alternatives,
    required List<String> alternativesAr,
    Map<String, dynamic>? variations,
    int? metValue,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}

@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required String userId,
    required String workoutPlanId,
    required int dayNumber,
    required DateTime startedAt,
    DateTime? completedAt,
    required WorkoutSessionStatus status,
    required List<CompletedExercise> exercises,
    int? totalDurationMinutes,
    int? totalCaloriesBurned,
    int? averageHeartRate,
    int? maxHeartRate,
    double? averageRpe,
    String? notes,
    String? mood,
    double? difficultyRating,
    @Default(false) bool isCompleted,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) => _$WorkoutSessionFromJson(json);
}

@freezed
class CompletedExercise with _$CompletedExercise {
  const factory CompletedExercise({
    required String exerciseId,
    required String name,
    required int plannedSets,
    required int completedSets,
    required List<CompletedSet> sets,
    int? actualDurationSeconds,
    double? averageRpe,
    String? notes,
    @Default(false) bool isCompleted,
  }) = _CompletedExercise;

  factory CompletedExercise.fromJson(Map<String, dynamic> json) => _$CompletedExerciseFromJson(json);
}

@freezed
class CompletedSet with _$CompletedSet {
  const factory CompletedSet({
    required int setNumber,
    required int reps,
    double? weight,
    double? rpe,
    int? durationSeconds,
    int? restSeconds,
    @Default(false) bool isCompleted,
    @Default(false) bool isWarmup,
    @Default(false) bool isDropSet,
  }) = _CompletedSet;

  factory CompletedSet.fromJson(Map<String, dynamic> json) => _$CompletedSetFromJson(json);
}

@freezed
class WorkoutPlanStats with _$WorkoutPlanStats {
  const factory WorkoutPlanStats({
    required int totalExercises,
    required int totalSets,
    required int estimatedDurationMinutes,
    required int estimatedCaloriesBurn,
    required Map<MuscleGroup, int> muscleGroupDistribution,
    required Map<ExerciseType, int> exerciseTypeDistribution,
    required Map<DifficultyLevel, int> difficultyDistribution,
  }) = _WorkoutPlanStats;

  factory WorkoutPlanStats.fromJson(Map<String, dynamic> json) => _$WorkoutPlanStatsFromJson(json);
}

enum MuscleGroup {
  @JsonValue('chest')
  chest,
  @JsonValue('back')
  back,
  @JsonValue('shoulders')
  shoulders,
  @JsonValue('biceps')
  biceps,
  @JsonValue('triceps')
  triceps,
  @JsonValue('forearms')
  forearms,
  @JsonValue('abs')
  abs,
  @JsonValue('obliques')
  obliques,
  @JsonValue('lower_back')
  lowerBack,
  @JsonValue('glutes')
  glutes,
  @JsonValue('quadriceps')
  quadriceps,
  @JsonValue('hamstrings')
  hamstrings,
  @JsonValue('calves')
  calves,
  @JsonValue('adductors')
  adductors,
  @JsonValue('abductors')
  abductors,
  @JsonValue('full_body')
  fullBody,
}

enum ExerciseType {
  @JsonValue('strength')
  strength,
  @JsonValue('cardio')
  cardio,
  @JsonValue('hiit')
  hiit,
  @JsonValue('mobility')
  mobility,
  @JsonValue('stretching')
  stretching,
  @JsonValue('plyometric')
  plyometric,
  @JsonValue('isometric')
  isometric,
  @JsonValue('functional')
  functional,
  @JsonValue('rehab')
  rehab,
}

enum WorkoutGoal {
  @JsonValue('build_muscle')
  buildMuscle,
  @JsonValue('lose_fat')
  loseFat,
  @JsonValue('strength')
  strength,
  @JsonValue('endurance')
  endurance,
  @JsonValue('power')
  power,
  @JsonValue('flexibility')
  flexibility,
  @JsonValue('rehabilitation')
  rehabilitation,
  @JsonValue('general_fitness')
  generalFitness,
  @JsonValue('sports_performance')
  sportsPerformance,
}

enum DifficultyLevel {
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
  @JsonValue('expert')
  expert,
}

enum WorkoutSessionStatus {
  @JsonValue('not_started')
  notStarted,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('paused')
  paused,
  @JsonValue('completed')
  completed,
  @JsonValue('skipped')
  skipped,
}

extension MuscleGroupExtension on MuscleGroup {
  String get nameAr {
    switch (this) {
      case MuscleGroup.chest:
        return 'الصدر';
      case MuscleGroup.back:
        return 'الظهر';
      case MuscleGroup.shoulders:
        return 'الكتف';
      case MuscleGroup.biceps:
        return 'العضلة ذات الرأسين';
      case MuscleGroup.triceps:
        return 'العضلة ثلاثية الرؤوس';
      case MuscleGroup.forearms:
        return 'الساعد';
      case MuscleGroup.abs:
        return 'البطن';
      case MuscleGroup.obliques:
        return 'الجانبين';
      case MuscleGroup.lowerBack:
        return 'أسفل الظهر';
      case MuscleGroup.glutes:
        return 'الألوية';
      case MuscleGroup.quadriceps:
        return 'الرباعية';
      case MuscleGroup.hamstrings:
        return 'الأوتار';
      case MuscleGroup.calves:
        return 'الساق';
      case MuscleGroup.adductors:
        return 'المقربة';
      case MuscleGroup.abductors:
        return 'المباعدة';
      case MuscleGroup.fullBody:
        return 'الجسم كاملاً';
    }
  }
}

extension ExerciseTypeExtension on ExerciseType {
  String get nameAr {
    switch (this) {
      case ExerciseType.strength:
        return 'قوة';
      case ExerciseType.cardio:
        return 'كارديو';
      case ExerciseType.hiit:
        return 'HIIT';
      case ExerciseType.mobility:
        return 'مرونة';
      case ExerciseType.stretching:
        return 'إطالة';
      case ExerciseType.plyometric:
        return 'بليومتريك';
      case ExerciseType.isometric:
        return 'أيزومتريك';
      case ExerciseType.functional:
        return 'وظيفي';
      case ExerciseType.rehab:
        return 'تأهيل';
    }
  }
}

extension WorkoutGoalExtension on WorkoutGoal {
  String get nameAr {
    switch (this) {
      case WorkoutGoal.buildMuscle:
        return 'بناء عضلات';
      case WorkoutGoal.loseFat:
        return 'حرق دهون';
      case WorkoutGoal.strength:
        return 'قوة';
      case WorkoutGoal.endurance:
        return 'تحمل';
      case WorkoutGoal.power:
        return 'قوة انفجارية';
      case WorkoutGoal.flexibility:
        return 'مرونة';
      case WorkoutGoal.rehabilitation:
        return 'تأهيل';
      case WorkoutGoal.generalFitness:
        return 'لياقة عامة';
      case WorkoutGoal.sportsPerformance:
        return 'أداء رياضي';
    }
  }
}

extension DifficultyLevelExtension on DifficultyLevel {
  String get nameAr {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'مبتدئ';
      case DifficultyLevel.intermediate:
        return 'متوسط';
      case DifficultyLevel.advanced:
        return 'متقدم';
      case DifficultyLevel.expert:
        return 'محترف';
    }
  }

  Color get color {
    switch (this) {
      case DifficultyLevel.beginner:
        return const Color(0xFF4CAF50);
      case DifficultyLevel.intermediate:
        return const Color(0xFF2196F3);
      case DifficultyLevel.advanced:
        return const Color(0xFFFF9800);
      case DifficultyLevel.expert:
        return const Color(0xFFF44336);
    }
  }
}