part of '../models.dart';

@freezed
abstract class AttributeValue with _$AttributeValue {
  const factory AttributeValue({
    @Default(0) int id,
    @Default('') String value,
  }) = _AttributeValue;

  factory AttributeValue.fromJson(Map<String, dynamic> json) => _$AttributeValueFromJson(json);
}
