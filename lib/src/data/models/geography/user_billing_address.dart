part of '../models.dart';

@freezed
abstract class UserBillingAddress with _$UserBillingAddress {
  const factory UserBillingAddress({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String phone,
    @Default(Nation()) Nation national,
    @Default(City()) City city,
    @Default(District()) District district,
    @Default(Ward()) Ward ward,
    @Default('') String detail,
    @Default(false) bool isDefault,
  }) = _UserBillingAddress;

  factory UserBillingAddress.fromJson(Map<String, dynamic> json) => _$UserBillingAddressFromJson(json);
}
