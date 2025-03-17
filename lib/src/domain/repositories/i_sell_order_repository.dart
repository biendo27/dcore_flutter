part of 'repositories.dart';

abstract interface class ISellOrderRepository {
  Future<BaseResponse<BasePageBreak<UserOrder>>> fetchOrder(String code, UserOrderStatusType status, int page);
  Future<BaseResponse<UserOrder>> fetchOrderDetail(int orderId);
  Future<BaseResponseList<OrderStatus>> fetchOrderStatuses();
  Future<BaseResponseList<OrderDeliveryStatus>> fetchOrderStatus(int orderId);
  Future<BaseResponse<OrderOverviewInfo>> updateOrderInfo(Map<String, dynamic> body);
  Future<BaseResponse<OrderResultResponse>> saveOrder(Map<String, dynamic> body);
  Future<BaseResponse<BasePageBreak<Voucher>>> storeVoucher(int storeId, int totalPrice, int page);
  Future<BaseResponse<BasePageBreak<Voucher>>> orderVoucher(
      int totalPrice, VoucherClassification classification, int page);
  Future<BaseResponse<Voucher>> getVoucherByCode(String code, int totalPrice);
  Future<BaseResponse> sendMail(Map<String, dynamic> body);
  Future<BaseResponseList<OrderReview>> getReview(int orderProductId);
  Future<BaseResponse> review(Map<String, dynamic> body);
  Future<BaseResponse<OrderCancelInfo>> cancelInfo(int orderId);
  Future<BaseResponseList<OrderCancelCategory>> cancelCategories();
  Future<BaseResponse> cancelSave(Map<String, dynamic> body);
  Future<BaseResponse<OrderReturnInfo>> returnInfo(int orderId);
  Future<BaseResponseList<OrderReturnCategory>> returnCategories();
  Future<BaseResponse> returnCreate(Map<String, dynamic> body);
  Future<BaseResponse> receiveConfirm(int orderId);
  Future<BaseResponseList<PaymentMethod>> fetchPaymentMethods();
  Future<BaseResponse<BasePageBreak<ProductReview>>> fetchUserReview(int page);
  Future<BaseResponse<BasePageBreak<OrderProduct>>> fetchUserReviewPending(int page);
}
