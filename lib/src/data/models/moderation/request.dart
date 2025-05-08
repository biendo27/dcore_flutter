part of '../models.dart';

@freezed
abstract class ModerationRequest with _$ModerationRequest {
  const factory ModerationRequest({
    @Default('') String id,
    @Default(0) double timestamp,
    @Default(0) int operations,
  }) = _ModerationRequest;

  factory ModerationRequest.fromJson(Map<String, dynamic> json) => _$ModerationRequestFromJson(json);
}
