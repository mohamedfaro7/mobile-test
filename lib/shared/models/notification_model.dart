import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String titleAr,
    required String body,
    required String bodyAr,
    String? imageUrl,
    String? actionUrl,
    Map<String, dynamic>? data,
    required bool isRead,
    required DateTime createdAt,
    DateTime? readAt,
    @Default(NotificationPriority.normal) NotificationPriority priority,
    List<NotificationAction>? actions,
    String? groupId,
    @Default(false) bool isPersistent,
    DateTime? expiresAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}

@freezed
class NotificationAction with _$NotificationAction {
  const factory NotificationAction({
    required String id,
    required String label,
    required String labelAr,
    required String actionType,
    Map<String, dynamic>? payload,
    String? icon,
    @Default(false) bool isDestructive,
    @Default(false) bool requiresAuth,
  }) = _NotificationAction;

  factory NotificationAction.fromJson(Map<String, dynamic> json) => _$NotificationActionFromJson(json);
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
    @Default(true) bool achievementNotifications,
    @Default(true) bool socialNotifications,
    @Default(true) bool systemNotifications,
    String? sound,
    @Default(true) bool vibration,
    @Default(true) bool badge,
    @Default('22:00') String quietHoursStart,
    @Default('07:00') String quietHoursEnd,
    @Default(true) bool respectQuietHours,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => _$NotificationSettingsFromJson(json);
}

@freezed
class ScheduledNotification with _$ScheduledNotification {
  const factory ScheduledNotification({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String titleAr,
    required String body,
    required String bodyAr,
    required DateTime scheduledAt,
    required RecurrenceRule? recurrence,
    Map<String, dynamic>? data,
    String? sound,
    @Default(true) bool isEnabled,
    DateTime? createdAt,
    DateTime? lastTriggered,
    @Default(0) int triggerCount,
  }) = _ScheduledNotification;

  factory ScheduledNotification.fromJson(Map<String, dynamic> json) => _$ScheduledNotificationFromJson(json);
}

@freezed
class RecurrenceRule with _$RecurrenceRule {
  const factory RecurrenceRule({
    required RecurrenceFrequency frequency,
    @Default(1) int interval,
    List<int>? daysOfWeek,
    int? dayOfMonth,
    TimeOfDay? timeOfDay,
    DateTime? startDate,
    DateTime? endDate,
    int? maxOccurrences,
  }) = _RecurrenceRule;

  factory RecurrenceRule.fromJson(Map<String, dynamic> json) => _$RecurrenceRuleFromJson(json);
}

@freezed
class TimeOfDay with _$TimeOfDay {
  const factory TimeOfDay({
    required int hour,
    required int minute,
  }) = _TimeOfDay;

  factory TimeOfDay.fromJson(Map<String, dynamic> json) => _$TimeOfDayFromJson(json);
}

enum NotificationType {
  @JsonValue('meal_reminder')
  mealReminder,
  @JsonValue('workout_reminder')
  workoutReminder,
  @JsonValue('water_reminder')
  waterReminder,
  @JsonValue('progress_update')
  progressUpdate,
  @JsonValue('achievement')
  achievement,
  @JsonValue('subscription_expiring')
  subscriptionExpiring,
  @JsonValue('payment_failed')
  paymentFailed,
  @JsonValue('payment_success')
  paymentSuccess,
  @JsonValue('food_delivery_status')
  foodDeliveryStatus,
  @JsonValue('food_delivery_arrived')
  foodDeliveryArrived,
  @JsonValue('system')
  system,
  @JsonValue('promotional')
  promotional,
  @JsonValue('social')
  social,
  @JsonValue('custom')
  custom,
}

enum NotificationPriority {
  @JsonValue('low')
  low,
  @JsonValue('normal')
  normal,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

enum RecurrenceFrequency {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
  @JsonValue('custom')
  custom,
}

enum ActionType {
  @JsonValue('navigate')
  navigate,
  @JsonValue('dismiss')
  dismiss,
  @JsonValue('snooze')
  snooze,
  @JsonValue('complete')
  complete,
  @JsonValue('view_details')
  viewDetails,
  @JsonValue('custom')
  custom,
}

extension NotificationTypeExtension on NotificationType {
  String get nameAr {
    switch (this) {
      case NotificationType.mealReminder:
        return 'تذكير وجبة';
      case NotificationType.workoutReminder:
        return 'تذكير تمرين';
      case NotificationType.waterReminder:
        return 'تذكير ماء';
      case NotificationType.progressUpdate:
        return 'تحديث تقدم';
      case NotificationType.achievement:
        return 'إنجاز';
      case NotificationType.subscriptionExpiring:
        return 'انتهاء اشتراك';
      case NotificationType.paymentFailed:
        return 'فشل دفع';
      case NotificationType.paymentSuccess:
        return 'نجاح دفع';
      case NotificationType.foodDeliveryStatus:
        return 'حالة توصيل';
      case NotificationType.foodDeliveryArrived:
        return 'وصل التوصيل';
      case NotificationType.system:
        return 'نظام';
      case NotificationType.promotional:
        return 'ترويجي';
      case NotificationType.social:
        return 'اجتماعي';
      case NotificationType.custom:
        return 'مخصص';
    }
  }

  String get defaultIcon {
    switch (this) {
      case NotificationType.mealReminder:
        return '🍽️';
      case NotificationType.workoutReminder:
        return '💪';
      case NotificationType.waterReminder:
        return '💧';
      case NotificationType.progressUpdate:
        return '📊';
      case NotificationType.achievement:
        return '🏆';
      case NotificationType.subscriptionExpiring:
        return '⏰';
      case NotificationType.paymentFailed:
        return '❌';
      case NotificationType.paymentSuccess:
        return '✅';
      case NotificationType.foodDeliveryStatus:
        return '🚚';
      case NotificationType.foodDeliveryArrived:
        return '📦';
      case NotificationType.system:
        return '⚙️';
      case NotificationType.promotional:
        return '🎁';
      case NotificationType.social:
        return '👥';
      case NotificationType.custom:
        return '🔔';
    }
  }
}

extension NotificationPriorityExtension on NotificationPriority {
  int get sortOrder {
    switch (this) {
      case NotificationPriority.urgent:
        return 0;
      case NotificationPriority.high:
        return 1;
      case NotificationPriority.normal:
        return 2;
      case NotificationPriority.low:
        return 3;
    }
  }
}