part of '../blocs.dart';

@lazySingleton
class OrderListCubit extends Cubit<OrderListState> with CubitActionMixin<OrderListState> {
  final ISellOrderRepository _sellOrderRepository;
  OrderListCubit(this._sellOrderRepository) : super(OrderListState.initial());

  void setCurrentOrder(UserOrder order) => emit(state.copyWith(currentOrder: order));

  void fetchOrderList({bool isInit = false, UserOrderStatusType type = UserOrderStatusType.all}) async {
    if (state.userOrders.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.userOrders.nextPage;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.fetchOrder('', type, page),
      currentPageData: state.userOrders,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(userOrders: mergedPageBreakData),
    );
  }

  void fetchOrderDetail() async {
    int orderId = state.currentOrder.id;
    if (orderId == 0) return;
    executeAction(
      action: () => _sellOrderRepository.fetchOrderDetail(orderId),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) => emit(state.copyWith(currentOrder: response.data!)),
    );
  }

  void fetchOrderDeliveryStatuses({int orderId = 0}) async {
    int id = state.currentOrder.id;
    if (id == 0) id = orderId;
    if (id == 0) return;
    executeListAction(
      action: () => _sellOrderRepository.fetchOrderStatus(id),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) => emit(state.copyWith(orderDeliveryStatuses: response.data)),
    );
  }
}
