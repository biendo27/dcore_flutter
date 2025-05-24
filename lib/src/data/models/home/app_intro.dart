part of '../models.dart';

@freezed
abstract class AppIntro with _$AppIntro {
  const factory AppIntro({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String content,
    @Default('') String image,
    @Default('') String createdAt,
  }) = _AppIntro;

  factory AppIntro.fromJson(Map<String, dynamic> json) => _$AppIntroFromJson(json);
}
