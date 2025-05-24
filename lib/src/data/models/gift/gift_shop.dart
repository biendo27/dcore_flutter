part of '../models.dart';

@freezed
abstract class Awards with _$Awards {
  const factory Awards({
    @Default('') String typeAward,
    @Default('') String type,
    @Default(0) int coin,
    @Default(0) int wheel,
    @Default(Voucher()) Voucher voucher,
    @Default(Product()) Product product,
  }) = _Awards;

  factory Awards.fromJson(Map<String, dynamic> json) => _$AwardsFromJson(json);
}
