part of '../models.dart';

@freezed
abstract class ContentModerationSetting with _$ContentModerationSetting {
  const factory ContentModerationSetting({
    @Default(0) int apiUser,
    @Default('') String apiSecret,
    @Default(false) bool status,
  }) = _ContentModerationSetting;

  factory ContentModerationSetting.fromJson(Map<String, dynamic> json) => _$ContentModerationSettingFromJson(json);
}
