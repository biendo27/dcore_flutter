part of '../blocs.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState({
    @Default(false) bool isLoading,
    @Default(UserOrder()) UserOrder order,
    @Default(OrderOverviewInfo()) OrderOverviewInfo orderOverviewInfo,
    @Default(BasePageBreak<Voucher>()) BasePageBreak<Voucher> storeVouchers,
    @Default(BasePageBreak<Voucher>()) BasePageBreak<Voucher> orderShippingVouchers,
    @Default(BasePageBreak<Voucher>()) BasePageBreak<Voucher> orderVouchers,
    @Default(Voucher()) Voucher orderVoucherResult,
  }) = _OrderState;

  factory OrderState.initial() => OrderState();
}
