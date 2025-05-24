part of '../models.dart';

@freezed
abstract class AppNews with _$AppNews {
  const factory AppNews({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String content,
    @Default([]) List<String> images,
    @Default(null) DateTime? createdAt,
  }) = _AppNews;

  factory AppNews.fromJson(Map<String, dynamic> json) => _$AppNewsFromJson(json);
}
