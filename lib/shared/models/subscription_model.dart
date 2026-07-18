import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

@freezed
class SubscriptionPlanModel with _$SubscriptionPlanModel {
  const factory SubscriptionPlanModel({
    required String id,
    required String name,
    required String nameAr,
    required String description,
    required String descriptionAr,
    required SubscriptionPlan type,
    required double monthlyPrice,
    required double yearlyPrice,
    required int maxMembers,
    required List<PlanFeature> features,
    required List<String> includedServices,
    String? badge,
    String? badgeAr,
    int? discountPercentage,
    @Default(false) bool isPopular,
    @Default(true) bool isActive,
    int? sortOrder,
  }) = _SubscriptionPlanModel;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanModelFromJson(json);
}

@freezed
class PlanFeature with _$PlanFeature {
  const factory PlanFeature({
    required String key,
    required String name,
    required String nameAr,
    required String description,
    required String descriptionAr,
    required bool isIncluded,
    String? icon,
  }) = _PlanFeature;

  factory PlanFeature.fromJson(Map<String, dynamic> json) => _$PlanFeatureFromJson(json);
}

@freezed
class UserSubscription with _$UserSubscription {
  const factory UserSubscription({
    required String id,
    required String userId,
    required String planId,
    required SubscriptionPlan planType,
    required SubscriptionStatus status,
    required BillingCycle billingCycle,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime nextBillingDate,
    required double amountPaid,
    required String currency,
    String? paymentMethodId,
    String? transactionId,
    @Default(true) bool autoRenew,
    @Default(1) int currentMembers,
    List<MemberSlot>? members,
    DateTime? cancelledAt,
    String? cancellationReason,
    List<PaymentHistory>? paymentHistory,
  }) = _UserSubscription;

  factory UserSubscription.fromJson(Map<String, dynamic> json) => _$UserSubscriptionFromJson(json);
}

@freezed
class MemberSlot with _$MemberSlot {
  const factory MemberSlot({
    required String id,
    String? userId,
    String? name,
    String? email,
    String? phone,
    UserProfile? profile,
    @Default(false) bool isActive,
    DateTime? invitedAt,
    DateTime? joinedAt,
    @Default(InvitationStatus.pending) InvitationStatus status,
  }) = _MemberSlot;

  factory MemberSlot.fromJson(Map<String, dynamic> json) => _$MemberSlotFromJson(json);
}

@freezed
class PaymentHistory with _$PaymentHistory {
  const factory PaymentHistory({
    required String id,
    required DateTime date,
    required double amount,
    required String currency,
    required PaymentStatus status,
    required String paymentMethod,
    String? transactionId,
    String? invoiceUrl,
    String? failureReason,
  }) = _PaymentHistory;

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => _$PaymentHistoryFromJson(json);
}

@freezed
class SubscriptionPricing with _$SubscriptionPricing {
  const factory SubscriptionPricing({
    required String planId,
    required double monthlyPrice,
    required double yearlyPrice,
    required double monthlyPriceWithDiscount,
    required double yearlyPriceWithDiscount,
    int? discountPercentage,
    String? discountCode,
    DateTime? discountExpiresAt,
  }) = _SubscriptionPricing;

  factory SubscriptionPricing.fromJson(Map<String, dynamic> json) => _$SubscriptionPricingFromJson(json);
}

enum InvitationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('declined')
  declined,
  @JsonValue('expired')
  expired,
}

enum PaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('refunded')
  refunded,
  @JsonValue('cancelled')
  cancelled,
}

extension SubscriptionPlanExtension on SubscriptionPlanModel {
  double getYearlyPrice({bool withDiscount = false}) {
    if (withDiscount && discountPercentage != null && discountPercentage! > 0) {
      return yearlyPrice * (1 - discountPercentage! / 100);
    }
    return yearlyPrice;
  }

  double getMonthlyPrice({bool withDiscount = false}) {
    if (withDiscount && discountPercentage != null && discountPercentage! > 0) {
      return monthlyPrice * (1 - discountPercentage! / 100);
    }
    return monthlyPrice;
  }

  double getYearlySavings() {
    return (monthlyPrice * 12) - yearlyPrice;
  }

  double getYearlySavingsPercentage() {
    final monthlyTotal = monthlyPrice * 12;
    return ((monthlyTotal - yearlyPrice) / monthlyTotal * 100).roundToDouble();
  }
}