part of '../models.dart';

@freezed
class LiveArea with _$LiveArea {
  const factory LiveArea({
    @Default(0) int id,
    @Default('') String name,
    @Default(null) DateTime? createdAt,
    @Default('') String createdAtFormat,
  }) = _LiveArea;

  factory LiveArea.fromJson(Map<String, dynamic> json) => _$LiveAreaFromJson(json);
}
