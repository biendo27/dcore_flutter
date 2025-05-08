part of '../models.dart';

@freezed
abstract class LiveHeartSocketData with _$LiveHeartSocketData {
  const factory LiveHeartSocketData({
    @Default(0) int count,
    @Default(Live()) Live live,
    @Default('') String channel,
    @Default('') String socket,
  }) = _LiveHeartSocketData;

  factory LiveHeartSocketData.fromJson(Map<String, dynamic> json) => _$LiveHeartSocketDataFromJson(json);
}
