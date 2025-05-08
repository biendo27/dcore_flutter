part of '../models.dart';

@freezed
abstract class OrderCancelInfo with _$OrderCancelInfo {
  const factory OrderCancelInfo({
    @Default([]) List<OrderProduct> orderProducts,
    @Default(0) int totalRefundAmount,
    @Default(0) int productRefundAmount,
    @Default(0) int shippingRefundAmount,
  }) = _OrderCancelInfo;

  factory OrderCancelInfo.fromJson(Map<String, dynamic> json) => _$OrderCancelInfoFromJson(json);
}

@freezed
abstract class OrderCancelCategory with _$OrderCancelCategory {
  const factory OrderCancelCategory({
    @Default(0) int id,
    @Default('') String name,
    @Default(null) DateTime? createdAt,
  }) = _OrderCancelCategory;

  factory OrderCancelCategory.fromJson(Map<String, dynamic> json) => _$OrderCancelCategoryFromJson(json);
}
