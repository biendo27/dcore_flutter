part of '../blocs.dart';

@lazySingleton
class OrderPaymentMethodCubit extends Cubit<OrderPaymentMethodState> with CubitActionMixin<OrderPaymentMethodState> {
  final ISellOrderRepository _sellOrderRepository;
  OrderPaymentMethodCubit(this._sellOrderRepository) : super(OrderPaymentMethodState.initial());

  void fetchPaymentMethods() async {
    executeListAction(
      action: () => _sellOrderRepository.fetchPaymentMethods(),
      onSuccess: (response) {
        emit(state.copyWith(paymentMethods: response.data));
      },
    );
  }
}
