part of '../models.dart';

@freezed
abstract class LiveSchedule with _$LiveSchedule {
  const factory LiveSchedule({
    @Default('') String date,
    @Default([]) List<Live> details,
  }) = _LiveSchedule;

  factory LiveSchedule.fromJson(Map<String, dynamic> json) => _$LiveScheduleFromJson(json);
}

@freezed
abstract class LiveScheduleResponse with _$LiveScheduleResponse {
  const factory LiveScheduleResponse({
    @Default(Live()) Live nearestLive,
    @Default(BasePageBreak<LiveSchedule>()) BasePageBreak<LiveSchedule> lives,
  }) = _LiveScheduleResponse;

  factory LiveScheduleResponse.fromJson(Map<String, dynamic> json) => _$LiveScheduleResponseFromJson(json);
}
