part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class SellVoucherApi {
  @factoryMethod
  factory SellVoucherApi(@Named(DIKey.appDio) Dio dio) = _SellVoucherApi;

  @GET(AppEndpoint.voucher)
  Future<BaseResponseList<Voucher>> fetchVoucher(@Queries() Map<String, dynamic> queries);

  @GET(AppEndpoint.voucherDetail)
  Future<BaseResponse<Voucher>> fetchVoucherDetail(@Query('voucher_id') int voucherId);

  @POST(AppEndpoint.voucherAdd)
  Future<BaseResponse> addVoucher(@Part(name: 'voucher_id') int voucherId);

  @POST(AppEndpoint.voucherSave)
  Future<BaseResponse<Voucher>> saveVoucher(@Part(name: 'voucher_id') int voucherId);
  
  @GET(AppEndpoint.voucherUsageTerms)
  Future<BaseResponse<UsageTerm>> fetchVoucherUsageTerms(@Query('voucher_id') int voucherId);
}
