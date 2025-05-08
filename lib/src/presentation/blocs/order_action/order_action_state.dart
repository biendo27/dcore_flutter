part of '../blocs.dart';

@freezed
abstract class OrderActionState with _$OrderActionState {
  const factory OrderActionState({
    @Default(false) bool isLoading,
    @Default(UserOrder()) UserOrder currentOrder,
    @Default(OrderCancelInfo()) OrderCancelInfo cancelInfo,
    @Default(OrderCancelCategory()) OrderCancelCategory currentCancelCategory,
    @Default([]) List<OrderCancelCategory> cancelCategories,
    @Default(OrderReturnInfo()) OrderReturnInfo returnInfo,
    @Default(OrderReturnCategory()) OrderReturnCategory currentReturnCategory,
    @Default([]) List<OrderReturnCategory> returnCategories,
    @Default([]) List<String> actionImages,
    @Default('') String selectedReason,
  }) = _OrderActionState;

  factory OrderActionState.initial() => OrderActionState();
}
