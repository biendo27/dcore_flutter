part of '../models.dart';

@freezed
abstract class ShippingMethod with _$ShippingMethod {
  const factory ShippingMethod({
    @Default(0) int id,
    @Default('') String name,
    @Default(0) int fee,
    @Default(0) int discountedAmount,
    @Default('') String storeAddress,
    @Default(EstimatedTime()) EstimatedTime estimatedTime,
  }) = _ShippingMethod;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => _$ShippingMethodFromJson(json);
}

@freezed
abstract class EstimatedTime with _$EstimatedTime {
  const factory EstimatedTime({
    @Default(null) DateTime? from,
    @Default(null) DateTime? to,
  }) = _EstimatedTime;

  factory EstimatedTime.fromJson(Map<String, dynamic> json) => _$EstimatedTimeFromJson(json);
}

extension ShippingMethodExtension on ShippingMethod {
  String get expectedTimeText => "${estimatedTime.from?.dateMonthValueString ?? ''} - ${estimatedTime.to?.dateMonthValueString ?? ''}";
}
