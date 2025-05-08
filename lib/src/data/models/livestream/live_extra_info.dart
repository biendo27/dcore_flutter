part of '../models.dart';

@freezed
abstract class LiveExtraInfo with _$LiveExtraInfo {
  const factory LiveExtraInfo({
    @Default('') String term,
    @Default(Comment()) Comment pinned,
  }) = _LiveExtraInfo;

  factory LiveExtraInfo.fromJson(Map<String, dynamic> json) => _$LiveExtraInfoFromJson(json);
}
