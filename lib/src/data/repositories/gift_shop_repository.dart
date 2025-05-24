part of 'repositories.dart';

@LazySingleton(as: IGiftShopRepository)
class GiftShopRepository with DataStateConvertible implements IGiftShopRepository {
  final GiftShopApi _giftShopApi;
  GiftShopRepository(this._giftShopApi);

  @override
  Future<BaseResponseList<GiftMain>> fetchGiftShopList() {
    return requestList(apiCall: _giftShopApi.fetchGiftShopList);
  }
}
