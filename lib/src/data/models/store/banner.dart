part of '../models.dart';

@freezed
abstract class StoreBanner with _$StoreBanner {
  const factory StoreBanner({
    @Default(0) int id,
    @Default('') String image,
    @Default('') String title,
    @Default('') String url,
    @Default('') String description,
    @Default(0) int status,
    @Default(null) DateTime? createdAt,
  }) = _StoreBanner;

  factory StoreBanner.fromJson(Map<String, dynamic> json) => _$StoreBannerFromJson(json);
}
