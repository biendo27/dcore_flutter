part of '../blocs.dart';

@freezed
abstract class OrderPaymentMethodState with _$OrderPaymentMethodState {
  const factory OrderPaymentMethodState({
    @Default(false) bool isLoading,
    @Default([]) List<PaymentMethod> paymentMethods,
  }) = _OrderPaymentMethodState;

  factory OrderPaymentMethodState.initial() => const OrderPaymentMethodState();
}
