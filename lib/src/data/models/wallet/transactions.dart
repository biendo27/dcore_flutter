part of '../models.dart';

@freezed
abstract class Transactions with _$Transactions {
  const factory Transactions({
    @Default(1) int currentPage,
    @Default(0) int total,
    @Default([]) List<Transaction> data,
  }) = _Transactions;

  factory Transactions.fromJson(Map<String, dynamic> json) => _$TransactionsFromJson(json);
}
