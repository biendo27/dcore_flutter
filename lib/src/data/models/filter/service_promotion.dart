part of '../models.dart';

@freezed
abstract class ServicePromotionFilter with _$ServicePromotionFilter {
  const factory ServicePromotionFilter({
    @Default(0) int key,
    @Default('') String name,
  }) = _ServicePromotionFilter;

  factory ServicePromotionFilter.fromJson(Map<String, dynamic> json) => _$ServicePromotionFilterFromJson(json);
}
