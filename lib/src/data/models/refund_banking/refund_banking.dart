part of '../models.dart';

@freezed
abstract class RefundBanking with _$RefundBanking {
  const factory RefundBanking({
    @Default(0) int id,
    @Default(UserBank()) UserBank bank,
    @Default('') String bankOwner,
    @Default('') String bankNumber,
    @Default('') String phone,
  }) = _RefundBanking;

  factory RefundBanking.fromJson(Map<String, dynamic> json) => _$RefundBankingFromJson(json);
}

@freezed
abstract class UserBank with _$UserBank {
  const factory UserBank({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String code,
    @Default('') String bin,
    @Default('') String shortName,
    @Default('') String logo,
    @Default(0) int transferSupported,
    @Default(0) int lookupSupported,
    @Default(0) int support,
    @Default(0) int isTransfer,
    @Default('') String swiftCode,
  }) = _UserBank;

  factory UserBank.fromJson(Map<String, dynamic> json) => _$UserBankFromJson(json);
}
