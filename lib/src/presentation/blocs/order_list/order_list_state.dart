part of '../blocs.dart';

@freezed
abstract class OrderListState with _$OrderListState {
  const factory OrderListState({
    @Default(false) bool isLoading,
    @Default(BasePageBreak<UserOrder>()) BasePageBreak<UserOrder> userOrders,
    @Default(UserOrder()) UserOrder currentOrder,
    @Default([]) List<OrderDeliveryStatus> orderDeliveryStatuses,
  }) = _OrderListState;

  factory OrderListState.initial() => OrderListState();
}
