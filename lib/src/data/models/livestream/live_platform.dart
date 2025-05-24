part of '../models.dart';

@freezed
abstract class LivePlatform with _$LivePlatform {
  const factory LivePlatform({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String image,
    @Default(null) DateTime? createdAt,
    @Default('') String createdAtFormat,
  }) = _LivePlatform;

  factory LivePlatform.fromJson(Map<String, dynamic> json) => _$LivePlatformFromJson(json);
}
