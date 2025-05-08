part of '../models.dart';

@freezed
abstract class Wallet with _$Wallet {
  const factory Wallet({
    @Default(0) int wallet,
    @Default(Transactions()) Transactions transactions,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
