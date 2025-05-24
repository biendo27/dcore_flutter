part of '../models.dart';

@freezed
abstract class Attribute with _$Attribute {
  const factory Attribute({
    @Default(0) int id,
    @Default('') String name,
    @Default([]) List<AttributeValue> values,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}
