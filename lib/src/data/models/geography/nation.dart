part of '../models.dart';

@freezed
abstract class Nation with _$Nation {
  const factory Nation({
    @Default(0) int id,
    @Default('') String name,
    // @Default('') String code,
  }) = _Nation;

  factory Nation.fromJson(Map<String, dynamic> json) => _$NationFromJson(json);
}
