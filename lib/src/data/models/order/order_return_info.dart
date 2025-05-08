part of '../models.dart';

@freezed
abstract class OrderReturnInfo with _$OrderReturnInfo {
  const factory OrderReturnInfo({
    @Default([]) List<OrderProduct> orderProducts,
    @Default(0) int totalRefundAmount,
    @Default(0) int productRefundAmount,
  }) = _OrderReturnInfo;

  factory OrderReturnInfo.fromJson(Map<String, dynamic> json) => _$OrderReturnInfoFromJson(json);
}

@freezed
abstract class OrderReturnCategory with _$OrderReturnCategory {
  const factory OrderReturnCategory({
    @Default(0) int id,
    @Default('') String name,
    @Default(null) DateTime? createdAt,
  }) = _OrderReturnCategory;

  factory OrderReturnCategory.fromJson(Map<String, dynamic> json) => _$OrderReturnCategoryFromJson(json);
}
