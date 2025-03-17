part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class AffiliateApi {
  @factoryMethod
  factory AffiliateApi(@Named(DIKey.appDio) Dio dio) = _AffiliateApi;

  @GET(AppEndpoint.affiliateRequest)
  Future<BaseResponseList<AffiliateRequest>> affiliateRequest();

  @POST(AppEndpoint.affiliateAddProduct)
  Future<BaseResponse> affiliateAddProduct(@Part(name: 'product_id') int productId);

  @GET(AppEndpoint.affiliateCommission)
  Future<BaseResponse<CommissionRepository>> affiliateCommission(@Query('page') int page);

  @GET(AppEndpoint.affiliateHome)
  Future<BaseResponse<HomeAffiliateRepository>> affiliateHome(@Query('page') int page);

  @GET(AppEndpoint.affiliateMoneyToCoin)
  Future<BaseResponse<int>> affiliateMoneyToCoin(@Query('money') int money);

  @GET(AppEndpoint.affiliateProductList)
  Future<BaseResponse<ProductList>> affiliateProductList(
    @Query('rating') int? rating,
    @Query('category_id') int? categoryId,
    @Query('from_price') int? fromPrice,
    @Query('to_price') int? toPrice,
    @Query('service_promotion') int? servicePromotion,
    @Query('type') int? type,
    @Query('sort') String? sort,
    @Query('keyword') String? keyword,
    @Query('commision') String? commision,
    @Query('page') int? page,
  );

  @GET(AppEndpoint.affiliateInfo)
  Future<BaseResponse<AffiliateInfo>> affiliateInfo();

  @POST(AppEndpoint.affiliateRegister)
  Future<BaseResponse> affiliateRegister(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.affiliateUpdate)
  Future<BaseResponse> affiliateUpdate(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.affiliateWithdraw)
  Future<BaseResponse> affiliateWithdraw(@Query('money') int money);

  @GET(AppEndpoint.affiliateProduct)
  Future<BaseResponseList<Product>> affiliateProduct();
}
