part of '../models.dart';

@freezed
abstract class PriceRangeFilter with _$PriceRangeFilter {
  const factory PriceRangeFilter({
    @Default('') String name,
    @Default(0) int from,
    @Default(0) int to,
  }) = _PriceRangeFilter;

  factory PriceRangeFilter.fromJson(Map<String, dynamic> json) => _$PriceRangeFilterFromJson(json);
}
