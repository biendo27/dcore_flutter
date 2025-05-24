part of '../models.dart';

@freezed
abstract class LivestreamSetting with _$LivestreamSetting {
  const factory LivestreamSetting({
    @Default('') String appId,
    @Default('') String appCertificate,
    @Default(false) bool status,
  }) = _LivestreamSetting;

  factory LivestreamSetting.fromJson(Map<String, dynamic> json) => _$LivestreamSettingFromJson(json);
}
