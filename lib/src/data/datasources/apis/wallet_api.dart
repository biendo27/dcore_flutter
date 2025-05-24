part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class WalletApi {
  @factoryMethod
  factory WalletApi(@Named(DIKey.appDio) Dio dio) = _WalletApi;

  @GET(AppEndpoint.wallet)
  Future<BaseResponse<Wallet>> fetchWallet(@Query('page') int page);

  @POST(AppEndpoint.walletWithdraw)
  Future<BaseResponse<Transaction>> requestWithdraw(
      @Query('coin') int coin, @Query('bank_name') String bankName, @Query('bank_number') String bankNumber, @Query('bank_owner') String bankOwner, @Query('note') String note);

  @GET(AppEndpoint.walletDetail)
  Future<BaseResponse<Transaction>> fetchWalletDetail(@Query('transaction_id') int transactionId);

  @GET(AppEndpoint.walletBanking)
  Future<BaseResponse<Banking>> walletBanking(@Query('transaction_id') int transactionId);

  @POST(AppEndpoint.walletDeposit)
  Future<BaseResponse<Transaction>> walletDeposit(@Query('package_id') int packageId, @Query('payment_method_id') int paymentMethodId);

  @GET(AppEndpoint.walletPackage)
  Future<BaseResponse<PackageResponse>> walletPackage();

  @GET(AppEndpoint.walletPaymentMethod)
  Future<BaseResponseList<PaymentMethod>> walletPaymentMethod();

  @GET(AppEndpoint.walletPolicy)
  Future<BaseResponse<String>> walletPolicy();

  @POST(AppEndpoint.walletUploadDeposit)
  Future<BaseResponse<Transaction>> walletUploadDeposit(@Query("image") String image, @Query("transaction_id") String transactionId);

  @GET(AppEndpoint.walletChangeCoinToMoney)
  Future<BaseResponse<int>> requestChangeCoinToMoney(@Query('coin') int coin);

  @POST(AppEndpoint.walletInAppPurchase)
  Future<BaseResponse<Transaction>> walletInAppPurchase(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.walletCreatePaymentVNPayTransaction)
  Future<BaseResponse<String>> walletCreatePaymentVNPayTransaction(@Query('transaction_id') int transactionId);

  @GET(AppEndpoint.walletCreatePaymentVNPayOrder)
  Future<BaseResponse<String>> walletCreatePaymentVNPayOrder(@Query('order_group_id') int orderGroupId);
}
