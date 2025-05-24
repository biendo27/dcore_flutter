part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class SellCartApi {
  @factoryMethod
  factory SellCartApi(@Named(DIKey.appDio) Dio dio) = _SellCartApi;

  @GET(AppEndpoint.cart)
  Future<BaseResponse<UserCart>> fetchCart();

  @GET(AppEndpoint.cartGetProductByVariant)
  Future<BaseResponse<Product>> fetchProductByVariant(@Queries() Map<String, dynamic> queries);

  @POST(AppEndpoint.cartAdd)
  Future<BaseResponse> addCart(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.cartUpdate)
  Future<BaseResponse> updateCart(@Body() Map<String, dynamic> body);

  @DELETE(AppEndpoint.cartDelete)
  Future<BaseResponse> deleteCart(@Query('cart_id') int cartId);
}
