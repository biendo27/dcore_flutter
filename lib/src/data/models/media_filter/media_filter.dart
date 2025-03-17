part of '../models.dart';

@freezed
class MediaFilter with _$MediaFilter {
  const factory MediaFilter({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String image,
    @Default('') String createdAt,
  }) = _MediaFilter;

  factory MediaFilter.fromJson(Map<String, dynamic> json) => _$MediaFilterFromJson(json);
}
