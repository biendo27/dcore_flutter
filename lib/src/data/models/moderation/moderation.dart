part of '../models.dart';

@freezed
abstract class ModerationResponse with _$ModerationResponse {
  const factory ModerationResponse({
    @Default('') String status,
    @Default(ModerationRequest()) ModerationRequest request,
    @Default(ModerationMedia()) ModerationMedia media,
    @Default(ModerationError()) ModerationError error,
  }) = _ModerationResponse;

  factory ModerationResponse.fromJson(Map<String, dynamic> json) => _$ModerationResponseFromJson(json);
}
