part of '../models.dart';

@freezed
class ModerationMedia with _$ModerationMedia {
  const factory ModerationMedia({
    @Default('') String id,
    @Default('') String uri,
  }) = _ModerationMedia;

  factory ModerationMedia.fromJson(Map<String, dynamic> json) =>
      _$ModerationMediaFromJson(json);
}

