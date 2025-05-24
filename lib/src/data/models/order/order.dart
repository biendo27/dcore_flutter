part of '../models.dart';

@freezed
abstract class UserOrder with _$UserOrder {
  const factory UserOrder({
    @Default(0) int id,
    @Default(OrderStatus()) OrderStatus status,
    @Default(UserBillingAddress()) UserBillingAddress billingAddress,
    @Default([]) List<OrderProduct> orderProducts,
    @Default('') String note,
    @Default(0) int totalQuantity,
    @Default(0) double finalTotalOrderPrice,
    @Default(0) double totalOrderPrice,
    @Default(0) double finalShippingFee,
    @Default(0) double shippingDiscount,
    @Default(0) double priceDiscount,
    @Default('') String code,
    @Default(PaymentMethod()) PaymentMethod paymentMethod,
    @Default('') String shipmentCode,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? paymentDate,
    @Default(null) DateTime? shippingDate,
    @Default(null) DateTime? cancelDate,
    @Default(AppUser()) AppUser user,
    @Default(Store()) Store store,
    @Default(false) bool isBuyAgain,
    @Default(false) bool isCancel,
    @Default(false) bool isReview,
    @Default(false) bool isTracking,
    @Default(false) bool isReturn,
    @Default(false) bool isConfirm,
  }) = _UserOrder;

  factory UserOrder.fromJson(Map<String, dynamic> json) => _$UserOrderFromJson(json);
}

@freezed
abstract class OrderResultResponse with _$OrderResultResponse {
  const factory OrderResultResponse({
    @Default(0) int orderGroupId,
  }) = _OrderResultResponse;

  factory OrderResultResponse.fromJson(Map<String, dynamic> json) => _$OrderResultResponseFromJson(json);
}

@freezed
abstract class LiveOrderSocketData with _$LiveOrderSocketData {
  const factory LiveOrderSocketData({
    @Default('') String message,
    @Default(Live()) Live live,
    @Default('') String channel,
    @Default('') String socket,
  }) = _LiveOrderSocketData;

  factory LiveOrderSocketData.fromJson(Map<String, dynamic> json) => _$LiveOrderSocketDataFromJson(json);
}
