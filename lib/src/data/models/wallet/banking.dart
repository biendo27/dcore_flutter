part of '../models.dart';

@freezed
abstract class Banking with _$Banking {
  const factory Banking({
    @Default(0) int transactionId,
    @Default('') String qr,
    @Default('') String note,
    @Default('') String bankName,
    @Default('') String bankNumber,
    @Default('') String bankOwner,
  }) = _Banking;

  factory Banking.fromJson(Map<String, dynamic> json) => _$BankingFromJson(json);
}
