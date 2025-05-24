part of '../models.dart';

@freezed
abstract class HashTag with _$HashTag {
  const factory HashTag({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String moveExplore,
    @Default('') String moveToBanner,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(null) DateTime? deletedAt,
  }) = _HashTag;

  factory HashTag.fromJson(Map<String, dynamic> json) => _$HashTagFromJson(json);
}
