part of '../models.dart';

@freezed
abstract class LiveViewerSocketData with _$LiveViewerSocketData {
  const factory LiveViewerSocketData({
    @Default([]) List<AppUser> users,
    @Default('') String channel,
    @Default('') String socket,
  }) = _LiveViewerSocketData;

  factory LiveViewerSocketData.fromJson(Map<String, dynamic> json) => _$LiveViewerSocketDataFromJson(json);
}
