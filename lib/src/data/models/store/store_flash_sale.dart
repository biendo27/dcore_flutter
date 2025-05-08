part of '../models.dart';

@freezed
abstract class StoreFlashSale with _$StoreFlashSale {
  const factory StoreFlashSale({
    @Default(0) int id,
    @Default([]) List<String> images,
    @Default(null) DateTime? startTime,
    @Default(null) DateTime? endTime,
    @Default('') String startTimeFormat,
    @Default('') String endTimeFormat,
    @Default([]) List<Product> products,
    @Default('') String name,
    @Default('') String type,
    @Default('') String saleType,
    @Default(0) int status,
  }) = _StoreFlashSale;

  factory StoreFlashSale.fromJson(Map<String, dynamic> json) => _$StoreFlashSaleFromJson(json);
}
