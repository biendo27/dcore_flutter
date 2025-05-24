part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class RefundBankingApi {
  @factoryMethod
  factory RefundBankingApi(@Named(DIKey.appDio) Dio dio) = _RefundBankingApi;

  @GET(AppEndpoint.refundBanking)
  Future<BaseResponse<RefundBanking>> fetchRefundBanking();

  @POST(AppEndpoint.refundBankingUpdate)
  Future<BaseResponse> updateRefundBanking(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.refundBankingListBankData)
  Future<BaseResponseList<UserBank>> fetchRefundBankingListBankData();
}
