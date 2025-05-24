part of '../blocs.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default(false) bool isLoading,
    @Default(UserCart()) UserCart userCart,
    @Default(BasePageBreak<Voucher>()) BasePageBreak<Voucher> orderVouchers,
    @Default(BasePageBreak<Voucher>()) BasePageBreak<Voucher> storeVouchers,
    @Default(Product()) Product productCart,
  }) = _CartState;

  factory CartState.initial() => CartState();
}
