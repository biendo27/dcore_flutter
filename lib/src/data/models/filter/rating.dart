part of '../models.dart';

@freezed
class RatingFilter with _$RatingFilter {
  const factory RatingFilter({
    @Default(0) int value,
    @Default('') String name,
  }) = _RatingFilter;

  factory RatingFilter.fromJson(Map<String, dynamic> json) => _$RatingFilterFromJson(json);
}
