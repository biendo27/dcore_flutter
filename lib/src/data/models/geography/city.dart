part of '../models.dart';

@freezed
abstract class City with _$City {
  const factory City({
    @Default(0) int id,
    @Default('') String name,
    // @Default('') String code,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
