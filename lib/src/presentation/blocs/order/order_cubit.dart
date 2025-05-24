part of '../blocs.dart';

@lazySingleton
class OrderCubit extends Cubit<OrderState> with CubitActionMixin<OrderState> {
  final ISellOrderRepository _sellOrderRepository;
  OrderCubit(this._sellOrderRepository) : super(OrderState.initial());

  void setOrderOverviewInfo(OrderOverviewInfo orderOverviewInfo) {
    emit(state.copyWith(orderOverviewInfo: orderOverviewInfo));
  }

  void setBillingAddressId(UserBillingAddress address) {
    OrderOverviewInfo orderOverviewInfo = state.orderOverviewInfo;
    orderOverviewInfo = orderOverviewInfo.copyWith(billingAddress: address);
    emit(state.copyWith(orderOverviewInfo: orderOverviewInfo));
  }

  void setListStoreInfo(List<OrderOverviewStoreInfo> storeInfos) {
    OrderOverviewInfo orderOverviewInfo = state.orderOverviewInfo;
    orderOverviewInfo = orderOverviewInfo.copyWith(stores: storeInfos);
    emit(state.copyWith(orderOverviewInfo: orderOverviewInfo));
  }

  void setPaymentMethod(PaymentMethod paymentMethod) {
    OrderOverviewInfo orderOverviewInfo = state.orderOverviewInfo;
    orderOverviewInfo = orderOverviewInfo.copyWith(paymentMethods: paymentMethod);
    emit(state.copyWith(orderOverviewInfo: orderOverviewInfo));
  }

  void setListOrderVoucher(List<Voucher> orderVouchers) {
    OrderOverviewInfo orderOverviewInfo = state.orderOverviewInfo;
    orderOverviewInfo = orderOverviewInfo.copyWith(vouchers: orderVouchers);
    emit(state.copyWith(orderOverviewInfo: orderOverviewInfo));
  }

  void setStoreNote(int storeId, String note) {
    final updatedStores = state.orderOverviewInfo.stores.map((store) {
      return store.infor.id == storeId ? store.copyWith(note: note) : store;
    }).toList();

    final updatedOrderOverviewInfo = state.orderOverviewInfo.copyWith(stores: updatedStores);

    emit(state.copyWith(orderOverviewInfo: updatedOrderOverviewInfo));
  }

  void setStoreOrderVoucher(int storeId, Voucher voucher) {
    if (voucher.id == 0) return;
    final updatedStores = state.orderOverviewInfo.stores.map((store) {
      return store.infor.id == storeId ? store.copyWith(orderVoucher: voucher) : store;
    }).toList();

    final updatedOrderOverviewInfo = state.orderOverviewInfo.copyWith(stores: updatedStores);

    emit(state.copyWith(orderOverviewInfo: updatedOrderOverviewInfo));
  }

  void setStoreShippingVoucher(int storeId, Voucher voucher) {
    if (voucher.id == 0) return;
    final updatedStores = state.orderOverviewInfo.stores.map((store) {
      return store.infor.id == storeId ? store.copyWith(shippingVoucher: voucher) : store;
    }).toList();

    final updatedOrderOverviewInfo = state.orderOverviewInfo.copyWith(stores: updatedStores);

    emit(state.copyWith(orderOverviewInfo: updatedOrderOverviewInfo));
  }

  void setStoreVoucher(int storeId, Voucher voucher) {
    final updatedStores = state.orderOverviewInfo.stores.map((store) {
      return store.infor.id == storeId ? store.copyWith(storeVoucher: voucher) : store;
    }).toList();

    final updatedOrderOverviewInfo = state.orderOverviewInfo.copyWith(stores: updatedStores);

    emit(state.copyWith(orderOverviewInfo: updatedOrderOverviewInfo));
  }

  void setOrderVoucher(Voucher voucher, Voucher shippingVoucher) {
    final updatedOrderOverviewInfo = state.orderOverviewInfo.copyWith(vouchers: [shippingVoucher, voucher]);
    emit(state.copyWith(orderOverviewInfo: updatedOrderOverviewInfo));
    OrderOverviewStoreInfo firstStore = state.orderOverviewInfo.stores.first;
    setStoreShippingVoucher(firstStore.infor.id, shippingVoucher);
  }

  void setIsUseCoin(bool isUseCoin) {
    OrderOverviewInfo orderOverviewInfo = state.orderOverviewInfo;
    orderOverviewInfo = orderOverviewInfo.copyWith(isUseCoin: isUseCoin);
    emit(state.copyWith(orderOverviewInfo: orderOverviewInfo));
  }

  void initUIData({
    required UserBillingAddress defaultAddress,
    required PaymentMethod paymentMethod,
    required Voucher orderVouchers,
    required List<StoreParam> storeParams,
  }) {
    int orderVoucherId = orderVouchers.id;
    OrderOverviewParam orderOverviewParam = OrderOverviewParam(
      billingAddressId: defaultAddress.id,
      paymentMethodId: paymentMethod.id,
      orderVoucherId: orderVoucherId,
      stores: storeParams,
    );
    updateOrderInfo(orderOverviewParam: orderOverviewParam);
  }

  List<Map<String, dynamic>> getProductItems(List<ProductParam> items) {
    return items
        .map((item) => {
              'product_id': item.productId,
              'quantity': item.quantity,
              'attribute_values': item.attributeValues,
              if (item.cartId != 0) 'cart_id': item.cartId,
              if (AppGlobalValue.affiliateId != 0) 'affiliate_id': AppGlobalValue.affiliateId,
            })
        .toList();
  }

  void updateOrderInfo({OrderOverviewParam? orderOverviewParam}) {
    orderOverviewParam ??= state.orderOverviewInfo.toOrderOverviewParam();
    List<StoreParam> stores = orderOverviewParam.stores;

    List<Map<String, dynamic>> storeData = stores
        .map((store) => {
              'store_id': store.storeId,
              'note': store.note,
              if (store.voucherId != 0) 'voucher_id': store.voucherId,
              if (store.shippingVoucherId != 0) 'shipping_voucher_id': store.shippingVoucherId,
              'items': getProductItems(store.items),
            })
        .toList();

    Map<String, dynamic> bodyData = {
      if (orderOverviewParam.billingAddressId != 0) 'billing_address_id': orderOverviewParam.billingAddressId,
      'stores': storeData,
      'payment_method_id': orderOverviewParam.paymentMethodId,
      if (orderOverviewParam.orderVoucherId != 0) 'order_voucher_id': orderOverviewParam.orderVoucherId,
      'is_use_coin': orderOverviewParam.isUseCoin,
    };

    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.updateOrderInfo(bodyData),
      onSuccess: (response) => emit(state.copyWith(orderOverviewInfo: response.data!)),
    );
  }

  void createOrder() {
    OrderOverviewParam orderOverviewParam = state.orderOverviewInfo.toOrderOverviewParam();
    List<StoreParam> stores = orderOverviewParam.stores;

    List<Map<String, dynamic>> storeData = stores
        .map((store) => {
              'store_id': store.storeId,
              'note': store.note,
              if (store.voucherId != 0) 'voucher_id': store.voucherId,
              if (store.shippingVoucherId != 0) 'shipping_voucher_id': store.shippingVoucherId,
              'items': getProductItems(store.items),
            })
        .toList();

    int liveId = AppConfig.context!.read<LiveCubit>().state.currentLive.id;

    Map<String, dynamic> bodyData = {
      if (orderOverviewParam.billingAddressId != 0) 'billing_address_id': orderOverviewParam.billingAddressId,
      'stores': storeData,
      'payment_method_id': orderOverviewParam.paymentMethodId,
      if (orderOverviewParam.orderVoucherId != 0) 'order_voucher_id': orderOverviewParam.orderVoucherId,
      'is_use_coin': orderOverviewParam.isUseCoin,
      if (liveId != 0) 'live_id': liveId,
    };

    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.saveOrder(bodyData),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        if (orderOverviewParam.paymentMethodId == 2) {
          AppConfig.context?.read<WalletCubit>().walletCreatePaymentVNPayOrder(
                response.data?.orderGroupId ?? 0,
                onSuccess: (url) => DNavigator.replaceNamed(RouteNamed.vnpayWebView, extra: url),
              );
          return;
        }

        DNavigator.replaceNamed(RouteNamed.paymentSuccess);
      },
    );
  }

  void getOrderVouchers({bool isInit = false}) {
    if (state.orderVouchers.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.orderVouchers.nextPage;
    int totalPrice = state.orderOverviewInfo.totalPrice;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.orderVoucher(totalPrice, VoucherClassification.price, page),
      currentPageData: state.orderVouchers,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(orderVouchers: mergedPageBreakData),
      onSuccess: (response) => emit(state.copyWith(orderVouchers: response.data!)),
    );
  }

  void getOrderShippingVouchers({bool isInit = false}) {
    if (state.orderShippingVouchers.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.orderShippingVouchers.nextPage;
    int totalPrice = state.orderOverviewInfo.totalPrice;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.orderVoucher(totalPrice, VoucherClassification.shipping, page),
      currentPageData: state.orderShippingVouchers,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(orderShippingVouchers: mergedPageBreakData),
      onSuccess: (response) => emit(state.copyWith(orderShippingVouchers: response.data!)),
    );
  }

  void getVoucherByCode(String code) {
    int totalPrice = state.orderOverviewInfo.totalPrice;
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.getVoucherByCode(code, totalPrice),
      onSuccess: (response) => emit(state.copyWith(orderVoucherResult: response.data!)),
    );
  }

  void clearOrderVoucherResult() {
    emit(state.copyWith(orderVoucherResult: Voucher(id: 0)));
  }

  void getStoreVouchers({bool isInit = false, required OrderOverviewStoreInfo storeInfo}) {
    if (state.storeVouchers.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.storeVouchers.nextPage;
    int totalPrice = storeInfo.totalPrice;
    int storeId = storeInfo.infor.id;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.storeVoucher(storeId, totalPrice, page),
      currentPageData: state.storeVouchers,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(storeVouchers: mergedPageBreakData),
      onSuccess: (response) => emit(state.copyWith(storeVouchers: response.data!)),
    );
  }
}
