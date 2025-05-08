part of '../models.dart';

@freezed
abstract class District with _$District {
  const factory District({
    @Default(0) int id,
    @Default('') String name,
    // @Default('') String code,
  }) = _District;

  factory District.fromJson(Map<String, dynamic> json) => _$DistrictFromJson(json);
}
