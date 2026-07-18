import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_delivery_model.freezed.dart';
part 'food_delivery_model.g.dart';

@freezed
class FoodOrder with _$FoodOrder {
  const factory FoodOrder({
    required String id,
    required String userId,
    required String mealPlanId,
    required List<OrderItem> items,
    required OrderStatus status,
    required DeliveryInfo delivery,
    required PaymentInfo payment,
    required PricingInfo pricing,
    required DateTime createdAt,
    DateTime? confirmedAt,
    DateTime? preparedAt,
    DateTime? dispatchedAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    String? notes,
    String? promoCode,
    double? discountAmount,
    List<OrderStatusHistory>? statusHistory,
    String? trackingUrl,
    String? driverId,
    String? driverName,
    String? driverPhone,
    double? driverRating,
    String? driverPhotoUrl,
    String? vehicleInfo,
    String? vehiclePlate,
  }) = _FoodOrder;

  const FoodOrder._();

  factory FoodOrder.fromJson(Map<String, dynamic> json) => _$FoodOrderFromJson(json);

  Duration? get estimatedDeliveryTime {
    if (dispatchedAt == null) return null;
    return deliveredAt?.difference(dispatchedAt!) ?? DateTime.now().difference(dispatchedAt!);
  }

  bool get canTrack => status == OrderStatus.preparing || status == OrderStatus.dispatched || status == OrderStatus.outForDelivery;
  bool get canCancel => status == OrderStatus.pending || status == OrderStatus.confirmed;
  bool get canRate => status == OrderStatus.delivered && driverRating == null;
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String id,
    required String mealId,
    required String mealName,
    required String mealNameAr,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    required String mealType,
    String? imageUrl,
    Map<String, dynamic>? nutritionInfo,
    List<String>? specialInstructions,
    List<OrderItemAddon>? addons,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
}

@freezed
class OrderItemAddon with _$OrderItemAddon {
  const factory OrderItemAddon({
    required String id,
    required String name,
    required String nameAr,
    required double price,
    required int quantity,
  }) = _OrderItemAddon;

  factory OrderItemAddon.fromJson(Map<String, dynamic> json) => _$OrderItemAddonFromJson(json);
}

@freezed
class DeliveryInfo with _$DeliveryInfo {
  const factory DeliveryInfo({
    required String addressId,
    required String fullAddress,
    required String building,
    required String floor,
    required String apartment,
    required String landmark,
    required double latitude,
    required double longitude,
    required String recipientName,
    required String recipientPhone,
    String? deliveryInstructions,
    DeliveryTimeSlot? preferredTimeSlot,
    @Default(false) bool contactlessDelivery,
  }) = _DeliveryInfo;

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => _$DeliveryInfoFromJson(json);
}

@freezed
class DeliveryTimeSlot with _$DeliveryTimeSlot {
  const factory DeliveryTimeSlot({
    required DateTime startTime,
    required DateTime endTime,
    String? label,
    String? labelAr,
  }) = _DeliveryTimeSlot;

  factory DeliveryTimeSlot.fromJson(Map<String, dynamic> json) => _$DeliveryTimeSlotFromJson(json);
}

@freezed
class PaymentInfo with _$PaymentInfo {
  const factory PaymentInfo({
    required PaymentMethod method,
    required PaymentStatus status,
    String? transactionId,
    String? paymentMethodId,
    String? cardLast4,
    String? cardBrand,
    double? amount,
    String? currency,
    DateTime? paidAt,
    String? failureReason,
  }) = _PaymentInfo;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => _$PaymentInfoFromJson(json);
}

@freezed
class PricingInfo with _$PricingInfo {
  const factory PricingInfo({
    required double subtotal,
    required double deliveryFee,
    required double tax,
    required double discount,
    required double total,
    required String currency,
    String? taxBreakdown,
    List<FeeItem>? fees,
  }) = _PricingInfo;

  factory PricingInfo.fromJson(Map<String, dynamic> json) => _$PricingInfoFromJson(json);
}

@freezed
class FeeItem with _$FeeItem {
  const factory FeeItem({
    required String name,
    required String nameAr,
    required double amount,
    required String type,
  }) = _FeeItem;

  factory FeeItem.fromJson(Map<String, dynamic> json) => _$FeeItemFromJson(json);
}

@freezed
class OrderStatusHistory with _$OrderStatusHistory {
  const factory OrderStatusHistory({
    required OrderStatus status,
    required DateTime timestamp,
    String? note,
    String? updatedBy,
    Map<String, dynamic>? metadata,
  }) = _OrderStatusHistory;

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) => _$OrderStatusHistoryFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    required String id,
    required String userId,
    required String label,
    required String labelAr,
    required String fullAddress,
    required String building,
    required String floor,
    required String apartment,
    required String landmark,
    required double latitude,
    required double longitude,
    required String recipientName,
    required String recipientPhone,
    @Default(false) bool isDefault,
    String? deliveryInstructions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@freezed
class DeliveryDriver with _$DeliveryDriver {
  const factory DeliveryDriver({
    required String id,
    required String name,
    required String phone,
    required String photoUrl,
    required double rating,
    required int totalDeliveries,
    required String vehicleType,
    required String vehiclePlate,
    required String vehicleColor,
    required bool isOnline,
    required double currentLatitude,
    required double currentLongitude,
    DateTime? lastLocationUpdate,
    String? currentOrderId,
  }) = _DeliveryDriver;

  factory DeliveryDriver.fromJson(Map<String, dynamic> json) => _$DeliveryDriverFromJson(json);
}

@freezed
class MealSubscription with _$MealSubscription {
  const factory MealSubscription({
    required String id,
    required String userId,
    required String mealPlanId,
    required String mealPlanName,
    required SubscriptionPlanType planType,
    required BillingCycle billingCycle,
    required int mealsPerDay,
    required int daysPerWeek,
    required List<DeliverySchedule> schedule,
    required List<String> mealTypes,
    required DateTime startDate,
    required DateTime? endDate,
    required SubscriptionStatus status,
    required PricingInfo pricing,
    String? promoCode,
    DateTime? nextDeliveryDate,
    List<Address>? deliveryAddresses,
    Map<String, dynamic>? preferences,
  }) = _MealSubscription;

  factory MealSubscription.fromJson(Map<String, dynamic> json) => _$MealSubscriptionFromJson(json);
}

@freezed
class DeliverySchedule with _$DeliverySchedule {
  const factory DeliverySchedule({
    required int dayOfWeek,
    required DeliveryTimeSlot timeSlot,
    required String addressId,
    @Default(true) bool isActive,
  }) = _DeliverySchedule;

  factory DeliverySchedule.fromJson(Map<String, dynamic> json) => _$DeliveryScheduleFromJson(json);
}

enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('preparing')
  preparing,
  @JsonValue('ready_for_pickup')
  readyForPickup,
  @JsonValue('dispatched')
  dispatched,
  @JsonValue('out_for_delivery')
  outForDelivery,
  @JsonValue('delivered')
  delivered,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('refunded')
  refunded,
  @JsonValue('failed')
  failed,
}

enum PaymentMethod {
  @JsonValue('card')
  card,
  @JsonValue('apple_pay')
  applePay,
  @JsonValue('google_pay')
  googlePay,
  @JsonValue('cash_on_delivery')
  cashOnDelivery,
  @JsonValue('wallet')
  wallet,
  @JsonValue('bank_transfer')
  bankTransfer,
}

enum PaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('authorized')
  authorized,
  @JsonValue('captured')
  captured,
  @JsonValue('failed')
  failed,
  @JsonValue('refunded')
  refunded,
  @JsonValue('partially_refunded')
  partiallyRefunded,
}

enum SubscriptionPlanType {
  @JsonValue('weekly')
  weekly,
  @JsonValue('bi_weekly')
  biWeekly,
  @JsonValue('monthly')
  monthly,
}

enum SubscriptionStatus {
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('expired')
  expired,
  @JsonValue('pending')
  pending,
}

enum BillingCycle {
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
}

extension OrderStatusExtension on OrderStatus {
  String get nameAr {
    switch (this) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.confirmed:
        return 'مؤكد';
      case OrderStatus.preparing:
        return 'قيد التحضير';
      case OrderStatus.readyForPickup:
        return 'جاهز للاستلام';
      case OrderStatus.dispatched:
        return 'تم الإرسال';
      case OrderStatus.outForDelivery:
        return 'في الطريق';
      case OrderStatus.delivered:
        return 'تم التسليم';
      case OrderStatus.cancelled:
        return 'ملغي';
      case OrderStatus.refunded:
        return 'مسترد';
      case OrderStatus.failed:
        return 'فشل';
    }
  }

  String get icon {
    switch (this) {
      case OrderStatus.pending:
        return '⏳';
      case OrderStatus.confirmed:
        return '✅';
      case OrderStatus.preparing:
        return '👨‍🍳';
      case OrderStatus.readyForPickup:
        return '📦';
      case OrderStatus.dispatched:
        return '🚚';
      case OrderStatus.outForDelivery:
        return '🛵';
      case OrderStatus.delivered:
        return '🎉';
      case OrderStatus.cancelled:
        return '❌';
      case OrderStatus.refunded:
        return '💰';
      case OrderStatus.failed:
        return '⚠️';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return const Color(0xFFFF9800);
      case OrderStatus.confirmed:
        return const Color(0xFF2196F3);
      case OrderStatus.preparing:
        return const Color(0xFF9C27B0);
      case OrderStatus.readyForPickup:
        return const Color(0xFF3F51B5);
      case OrderStatus.dispatched:
        return const Color(0xFF00BCD4);
      case OrderStatus.outForDelivery:
        return const Color(0xFF009688);
      case OrderStatus.delivered:
        return const Color(0xFF4CAF50);
      case OrderStatus.cancelled:
        return const Color(0xFFF44336);
      case OrderStatus.refunded:
        return const Color(0xFF607D8B);
      case OrderStatus.failed:
        return const Color(0xFF795548);
    }
  }

  int get progressStep {
    switch (this) {
      case OrderStatus.pending:
        return 1;
      case OrderStatus.confirmed:
        return 2;
      case OrderStatus.preparing:
        return 3;
      case OrderStatus.readyForPickup:
        return 4;
      case OrderStatus.dispatched:
        return 5;
      case OrderStatus.outForDelivery:
        return 6;
      case OrderStatus.delivered:
        return 7;
      case OrderStatus.cancelled:
      case OrderStatus.refunded:
      case OrderStatus.failed:
        return 0;
    }
  }
}

extension PaymentMethodExtension on PaymentMethod {
  String get nameAr {
    switch (this) {
      case PaymentMethod.card:
        return 'بطاقة';
      case PaymentMethod.applePay:
        return 'Apple Pay';
      case PaymentMethod.googlePay:
        return 'Google Pay';
      case PaymentMethod.cashOnDelivery:
        return 'الدفع عند الاستلام';
      case PaymentMethod.wallet:
        return 'المحفظة';
      case PaymentMethod.bankTransfer:
        return 'تحويل بنكي';
    }
  }
}