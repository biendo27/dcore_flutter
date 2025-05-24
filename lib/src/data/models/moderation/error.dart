part of '../models.dart';

@freezed
abstract class ModerationError with _$ModerationError {
  const factory ModerationError({
    @Default('') String type,
    @Default(0) int code,
    @Default('') String message,
  }) = _ModerationError;

  factory ModerationError.fromJson(Map<String, dynamic> json) => _$ModerationErrorFromJson(json);
}
