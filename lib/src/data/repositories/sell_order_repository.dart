part of 'repositories.dart';

@LazySingleton(as: ISellOrderRepository)
class SellOrderRepository with DataStateConvertible implements ISellOrderRepository {
  final SellOrderApi _sellOrderApi;
  SellOrderRepository(this._sellOrderApi);

  @override
  Future<BaseResponse<BasePageBreak<UserOrder>>> fetchOrder(String code, UserOrderStatusType status, int page) {
    return request(apiCall: () => _sellOrderApi.fetchOrder(code, status, page));
  }

  @override
  Future<BaseResponse<UserOrder>> fetchOrderDetail(int orderId) {
    return request(apiCall: () => _sellOrderApi.fetchOrderDetail(orderId));
  }

  @override
  Future<BaseResponseList<OrderStatus>> fetchOrderStatuses() {
    return requestList(apiCall: _sellOrderApi.fetchOrderStatuses);
  }

  @override
  Future<BaseResponseList<OrderDeliveryStatus>> fetchOrderStatus(int orderId) {
    return requestList(apiCall: () => _sellOrderApi.fetchOrderStatus(orderId));
  }

  @override
  Future<BaseResponse<OrderOverviewInfo>> updateOrderInfo(Map<String, dynamic> body) {
    return request(apiCall: () => _sellOrderApi.updateOrderInfo(body));
  }

  @override
  Future<BaseResponse<OrderResultResponse>> saveOrder(Map<String, dynamic> body) {
    return request(apiCall: () => _sellOrderApi.saveOrder(body));
  }

  @override
  Future<BaseResponse<BasePageBreak<Voucher>>> storeVoucher(int storeId, int totalPrice, int page) {
    return request(apiCall: () => _sellOrderApi.storeVoucher(storeId, totalPrice, page));
  }

  @override
  Future<BaseResponse<BasePageBreak<Voucher>>> orderVoucher(
      int totalPrice, VoucherClassification classification, int page) {
    return request(apiCall: () => _sellOrderApi.orderVoucher(totalPrice, classification, page));
  }

  @override
  Future<BaseResponse<Voucher>> getVoucherByCode(String code, int totalPrice) {
    return request(apiCall: () => _sellOrderApi.getVoucherByCode(code, totalPrice));
  }

  @override
  Future<BaseResponse> sendMail(Map<String, dynamic> body) {
    return request(apiCall: () => _sellOrderApi.sendMail(body));
  }

  @override
  Future<BaseResponseList<OrderReview>> getReview(int orderProductId) {
    return requestList(apiCall: () => _sellOrderApi.getReview(orderProductId));
  }

  @override
  Future<BaseResponse> review(Map<String, dynamic> body) {
    return request(apiCall: () => _sellOrderApi.review(body));
  }

  @override
  Future<BaseResponse<OrderCancelInfo>> cancelInfo(int orderId) {
    return request(apiCall: () => _sellOrderApi.cancelInfo(orderId));
  }

  @override
  Future<BaseResponseList<OrderCancelCategory>> cancelCategories() {
    return requestList(apiCall: _sellOrderApi.cancelCategories);
  }

  @override
  Future<BaseResponse> cancelSave(Map<String, dynamic> body) {
    return request(apiCall: () => _sellOrderApi.cancelSave(body));
  }

  @override
  Future<BaseResponse<OrderReturnInfo>> returnInfo(int orderId) {
    return request(apiCall: () => _sellOrderApi.returnInfo(orderId));
  }

  @override
  Future<BaseResponseList<OrderReturnCategory>> returnCategories() {
    return requestList(apiCall: _sellOrderApi.returnCategories);
  }

  @override
  Future<BaseResponse> returnCreate(Map<String, dynamic> body) {
    return request(apiCall: () => _sellOrderApi.returnSave(body));
  }

  @override
  Future<BaseResponse> receiveConfirm(int orderId) {
    return request(apiCall: () => _sellOrderApi.receiveConfirm(orderId));
  }

  @override
  Future<BaseResponseList<PaymentMethod>> fetchPaymentMethods() {
    return requestList(apiCall: _sellOrderApi.fetchPaymentMethods);
  }

  @override
  Future<BaseResponse<BasePageBreak<ProductReview>>> fetchUserReview(int page) {
    return request(apiCall: () => _sellOrderApi.fetchUserReview(page));
  }

  @override
  Future<BaseResponse<BasePageBreak<OrderProduct>>> fetchUserReviewPending(int page) {
    return request(apiCall: () => _sellOrderApi.fetchUserReviewPending(page));
  }
}
