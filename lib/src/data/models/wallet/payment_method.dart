part of '../models.dart';

@freezed
abstract class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String note,
    @Default('') String image,
    @Default(0) int status,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);
}
