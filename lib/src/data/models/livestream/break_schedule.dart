part of '../models.dart';

@freezed
abstract class BreakSchedule with _$BreakSchedule {
  const factory BreakSchedule({
    @Default(0) int id,
    @Default(0) int userId,
    @Default(null) DateTime? startAt,
    @Default(null) DateTime? endAt,
    @Default('') String reason,
    @Default(BreakScheduleStatus.pending) BreakScheduleStatus status,
    @Default(null) DateTime? createdAt,
  }) = _BreakSchedule;

  factory BreakSchedule.fromJson(Map<String, dynamic> json) => _$BreakScheduleFromJson(json);
}

enum BreakScheduleStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected;

  String get name {
    return switch (this) {
      pending => AppConfig.context!.text.pending,
      approved => AppConfig.context!.text.approved,
      rejected => AppConfig.context!.text.rejected,
    };
  }
}
