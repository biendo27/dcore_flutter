part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class SellProductApi {
  @factoryMethod
  factory SellProductApi(@Named(DIKey.appDio) Dio dio) = _SellProductApi;

  @GET(AppEndpoint.product)
  Future<BaseResponseList<Product>> fetchProduct(@Queries() Map<String, dynamic> queries);

  @GET(AppEndpoint.productFilter)
  Future<BaseResponse<Filter>> fetchProductFilter();

  @GET(AppEndpoint.productDetail)
  Future<BaseResponse<ProductDetail>> fetchProductDetail(@Query('product_id') int productId);

  @GET(AppEndpoint.productReview)
  Future<BaseResponse<BasePageBreak<ProductReview>>> fetchProductReview(@Query('product_id') int productId, @Query('page') int page);

  @POST(AppEndpoint.productPost)
  Future<BaseResponse> postProduct(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.otherProduct)
  Future<BaseResponseList<Product>> fetchOtherProduct(@Query('product_id') int productId);

  @GET(AppEndpoint.productVoucher)
  Future<BaseResponseList<Voucher>> fetchProductVoucher(@Query('product_id') int productId);

  @GET(AppEndpoint.productService)
  Future<BaseResponse<ProductService>> fetchProductService();

  @GET(AppEndpoint.productServiceDetail)
  Future<BaseResponse<String>> fetchProductServiceDetail(@Query('type') ProductServiceType type);

  @POST(AppEndpoint.productBookmark)
  Future<BaseResponse> bookmarkProduct(@Part(name: 'product_id') int productId);

  @GET(AppEndpoint.productSuggest)
  Future<BaseResponseList<Product>> fetchProductSuggest();

  @GET(AppEndpoint.productCancelOrderTutorialTerm)
  Future<BaseResponse<String>> fetchProductCancelOrderTutorialTerm();
}
