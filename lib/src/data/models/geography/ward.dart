part of '../models.dart';

@freezed
class Ward with _$Ward {
  const factory Ward({
    @Default(0) int id,
    @Default('') String name,
    // @Default('') String code,
  }) = _Ward;

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);
}

