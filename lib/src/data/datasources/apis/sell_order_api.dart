part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class SellOrderApi {
  @factoryMethod
  factory SellOrderApi(@Named(DIKey.appDio) Dio dio) = _SellOrderApi;

  @GET(AppEndpoint.order)
  Future<BaseResponse<BasePageBreak<UserOrder>>> fetchOrder(
      @Query('code') String code, @Query('status') UserOrderStatusType status, @Query('page') int page);

  @GET(AppEndpoint.orderDetail)
  Future<BaseResponse<UserOrder>> fetchOrderDetail(@Query('order_id') int orderId);

  @POST(AppEndpoint.orderInfoUpdate)
  Future<BaseResponse<OrderOverviewInfo>> updateOrderInfo(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.orderStatuses)
  Future<BaseResponseList<OrderStatus>> fetchOrderStatuses();

  @GET(AppEndpoint.orderStatus)
  Future<BaseResponseList<OrderDeliveryStatus>> fetchOrderStatus(@Query('order_id') int orderId);

  @POST(AppEndpoint.orderSave)
  Future<BaseResponse<OrderResultResponse>> saveOrder(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.orderStoreVoucher)
  Future<BaseResponse<BasePageBreak<Voucher>>> storeVoucher(
      @Query('store_id') int storeId, @Query('total_price') int totalPrice, @Query('page') int page);

  @GET(AppEndpoint.orderVoucher)
  Future<BaseResponse<BasePageBreak<Voucher>>> orderVoucher(@Query('total_price') int totalPrice,
      @Query('classification') VoucherClassification classification, @Query('page') int page);

  @GET(AppEndpoint.orderGetVoucherByCode)
  Future<BaseResponse<Voucher>> getVoucherByCode(@Query('code') String code, @Query('total_price') int totalPrice);

  @POST(AppEndpoint.orderSendMail)
  Future<BaseResponse> sendMail(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.orderGetReview)
  Future<BaseResponseList<OrderReview>> getReview(@Query('order_product_id') int orderProductId);

  @POST(AppEndpoint.orderReview)
  Future<BaseResponse> review(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.orderCancelInfo)
  Future<BaseResponse<OrderCancelInfo>> cancelInfo(@Query('order_id') int orderId);

  @GET(AppEndpoint.orderCancelCategories)
  Future<BaseResponseList<OrderCancelCategory>> cancelCategories();

  @POST(AppEndpoint.orderCancelSave)
  Future<BaseResponse> cancelSave(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.orderReturnInfo)
  Future<BaseResponse<OrderReturnInfo>> returnInfo(@Query('order_id') int orderId);

  @GET(AppEndpoint.orderReturnCategories)
  Future<BaseResponseList<OrderReturnCategory>> returnCategories();

  @POST(AppEndpoint.orderReturnCreate)
  Future<BaseResponse> returnSave(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.orderReceiveConfirm)
  Future<BaseResponse> receiveConfirm(@Part(name: 'order_id') int orderId);

  @GET(AppEndpoint.orderPaymentMethod)
  Future<BaseResponseList<PaymentMethod>> fetchPaymentMethods();

  @GET(AppEndpoint.userReview)
  Future<BaseResponse<BasePageBreak<ProductReview>>> fetchUserReview(@Query('page') int page);

  @GET(AppEndpoint.userReviewPending)
  Future<BaseResponse<BasePageBreak<OrderProduct>>> fetchUserReviewPending(@Query('page') int page);
}
