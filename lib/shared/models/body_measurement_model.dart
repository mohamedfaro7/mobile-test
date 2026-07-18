import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'body_measurement_model.freezed.dart';
part 'body_measurement_model.g.dart';

@freezed
class BodyMeasurements with _$BodyMeasurements {
  const factory BodyMeasurements({
    required String userId,
    required double heightCm,
    required double weightKg,
    double? bodyFatPercentage,
    double? muscleMassKg,
    double? boneMassKg,
    double? waterPercentage,
    double? bmi,
    double? bmr,
    double? tdee,
    double? waistCm,
    double? hipCm,
    double? chestCm,
    double? neckCm,
    double? bicepCm,
    double? thighCm,
    double? calfCm,
    double? shoulderCm,
    DateTime? measuredAt,
    List<BodyMeasurementLog>? history,
    BodyAnalysis? analysis,
  }) = _BodyMeasurements;

  const BodyMeasurements._();

  factory BodyMeasurements.fromJson(Map<String, dynamic> json) => _$BodyMeasurementsFromJson(json);

  double get bmiCalculated => weightKg / ((heightCm / 100) * (heightCm / 100));

  double get bmrCalculated {
    // Mifflin-St Jeor Equation (will need age and gender from user profile)
    return 0; // Placeholder
  }

  BodyCompositionCategory get bmiCategory {
    final bmi = bmiCalculated;
    if (bmi < 18.5) return BodyCompositionCategory.underweight;
    if (bmi < 25) return BodyCompositionCategory.normal;
    if (bmi < 30) return BodyCompositionCategory.overweight;
    if (bmi < 35) return BodyCompositionCategory.obese1;
    if (bmi < 40) return BodyCompositionCategory.obese2;
    return BodyCompositionCategory.obese3;
  }
}

@freezed
class BodyMeasurementLog with _$BodyMeasurementLog {
  const factory BodyMeasurementLog({
    required DateTime date,
    required double weightKg,
    double? bodyFatPercentage,
    double? muscleMassKg,
    double? waistCm,
    double? hipCm,
    double? chestCm,
    String? notes,
    String? photoUrl,
  }) = _BodyMeasurementLog;

  factory BodyMeasurementLog.fromJson(Map<String, dynamic> json) => _$BodyMeasurementLogFromJson(json);
}

@freezed
class BodyAnalysis with _$BodyAnalysis {
  const factory BodyAnalysis({
    required BodyCompositionCategory bmiCategory,
    required String bmiCategoryAr,
    required String bmiAdvice,
    required String bmiAdviceAr,
    required BodyFatCategory? bodyFatCategory,
    required String? bodyFatCategoryAr,
    required String? bodyFatAdvice,
    required String? bodyFatAdviceAr,
    required Map<String, BodyPartAnalysis> bodyParts,
    required List<String> strengths,
    required List<String> strengthsAr,
    required List<String> improvements,
    required List<String> improvementsAr,
    required double overallScore,
  }) = _BodyAnalysis;

  factory BodyAnalysis.fromJson(Map<String, dynamic> json) => _$BodyAnalysisFromJson(json);
}

@freezed
class BodyPartAnalysis with _$BodyPartAnalysis {
  const factory BodyPartAnalysis({
    required BodyPart part,
    required double measurement,
    required double idealMin,
    required double idealMax,
    required BodyPartStatus status,
    required String statusAr,
    required String advice,
    required String adviceAr,
  }) = _BodyPartAnalysis;

  factory BodyPartAnalysis.fromJson(Map<String, dynamic> json) => _$BodyPartAnalysisFromJson(json);
}

enum BodyCompositionCategory {
  @JsonValue('underweight')
  underweight,
  @JsonValue('normal')
  normal,
  @JsonValue('overweight')
  overweight,
  @JsonValue('obese_1')
  obese1,
  @JsonValue('obese_2')
  obese2,
  @JsonValue('obese_3')
  obese3,
}

enum BodyFatCategory {
  @JsonValue('essential')
  essential,
  @JsonValue('athletic')
  athletic,
  @JsonValue('fitness')
  fitness,
  @JsonValue('average')
  average,
  @JsonValue('above_average')
  aboveAverage,
  @JsonValue('obese')
  obese,
}

enum BodyPart {
  @JsonValue('waist')
  waist,
  @JsonValue('hip')
  hip,
  @JsonValue('chest')
  chest,
  @JsonValue('neck')
  neck,
  @JsonValue('bicep')
  bicep,
  @JsonValue('thigh')
  thigh,
  @JsonValue('calf')
  calf,
  @JsonValue('shoulder')
  shoulder,
  @JsonValue('forearm')
  forearm,
}

enum BodyPartStatus {
  @JsonValue('below_ideal')
  belowIdeal,
  @JsonValue('ideal')
  ideal,
  @JsonValue('above_ideal')
  aboveIdeal,
  @JsonValue('needs_attention')
  needsAttention,
}

extension BodyCompositionCategoryExtension on BodyCompositionCategory {
  String get nameAr {
    switch (this) {
      case BodyCompositionCategory.underweight:
        return 'نقص وزن';
      case BodyCompositionCategory.normal:
        return 'وزن طبيعي';
      case BodyCompositionCategory.overweight:
        return 'وزن زائد';
      case BodyCompositionCategory.obese1:
        return 'سمنة درجة أولى';
      case BodyCompositionCategory.obese2:
        return 'سمنة درجة ثانية';
      case BodyCompositionCategory.obese3:
        return 'سمنة درجة ثالثة';
    }
  }

  String get color {
    switch (this) {
      case BodyCompositionCategory.underweight:
        return '#2196F3';
      case BodyCompositionCategory.normal:
        return '#4CAF50';
      case BodyCompositionCategory.overweight:
        return '#FF9800';
      case BodyCompositionCategory.obese1:
        return '#FF5722';
      case BodyCompositionCategory.obese2:
        return '#F44336';
      case BodyCompositionCategory.obese3:
        return '#B71C1C';
    }
  }
}

extension BodyFatCategoryExtension on BodyFatCategory {
  String get nameAr {
    switch (this) {
      case BodyFatCategory.essential:
        return 'دهون أساسية';
      case BodyFatCategory.athletic:
        return 'رياضي';
      case BodyFatCategory.fitness:
        return 'لياقة';
      case BodyFatCategory.average:
        return 'متوسط';
      case BodyFatCategory.aboveAverage:
        return 'فوق المتوسط';
      case BodyFatCategory.obese:
        return 'سمنة';
    }
  }
}

extension BodyPartExtension on BodyPart {
  String get nameAr {
    switch (this) {
      case BodyPart.waist:
        return 'الخصر';
      case BodyPart.hip:
        return 'الورك';
      case BodyPart.chest:
        return 'الصدر';
      case BodyPart.neck:
        return 'الرقبة';
      case BodyPart.bicep:
        return 'العضلة ذات الرأسين';
      case BodyPart.thigh:
        return 'الفخذ';
      case BodyPart.calf:
        return 'الساق';
      case BodyPart.shoulder:
        return 'الكتف';
      case BodyPart.forearm:
        return 'الساعد';
    }
  }
}

extension BodyPartStatusExtension on BodyPartStatus {
  String get color {
    switch (this) {
      case BodyPartStatus.belowIdeal:
        return '#2196F3';
      case BodyPartStatus.ideal:
        return '#4CAF50';
      case BodyPartStatus.aboveIdeal:
        return '#FF9800';
      case BodyPartStatus.needsAttention:
        return '#F44336';
    }
  }
}