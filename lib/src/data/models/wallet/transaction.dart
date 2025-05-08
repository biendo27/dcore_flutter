part of '../models.dart';

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    @Default(0) int id,
    @Default('') String code,
    @Default(null) DateTime? createdAt,
    @Default('') String classification,
    @Default(0) int money,
    @Default(0) int coin,
    @Default('') String paymentMethod,
    @Default('') String bankName,
    @Default('') String bankNumber,
    @Default('') String bankOwner,
    @Default('') String note,
    @Default('') String status,
    @Default('') String image,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}
