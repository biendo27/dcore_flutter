part of '../models.dart';

@freezed
abstract class LiveRequest with _$LiveRequest {
  const factory LiveRequest({
    @Default(0) int id,
    @Default(null) DateTime? startAt,
    @Default(null) DateTime? endAt,
    @Default(BreakScheduleStatus.pending) BreakScheduleStatus status,
    @Default(null) DateTime? createdAt,
    @Default(LivePlatform()) LivePlatform livePlatform,
    @Default(LiveArea()) LiveArea area,
    @Default(AppUser()) AppUser user,
    @Default('') String startAtFormat,
    @Default('') String endAtFormat,
    @Default('') String createdAtFormat,
  }) = _LiveRequest;

  factory LiveRequest.fromJson(Map<String, dynamic> json) => _$LiveRequestFromJson(json);
}
