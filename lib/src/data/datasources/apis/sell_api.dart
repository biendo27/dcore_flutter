part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class SellApi {
  @factoryMethod
  factory SellApi(@Named(DIKey.appDio) Dio dio) = _SellApi;

  @GET(AppEndpoint.sell)
  Future<BaseResponse<StoreHome>> fetchSellHome();

  @GET(AppEndpoint.flashSell)
  Future<BaseResponse<StoreFlashSale>> fetchFlashSell();
}
