part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class GiftShopApi {
  @factoryMethod
  factory GiftShopApi(@Named(DIKey.appDio) Dio dio) = _GiftShopApi;

  @GET(AppEndpoint.giveGiftShop)
  Future<BaseResponseList<GiftMain>> fetchGiftShopList();
}
