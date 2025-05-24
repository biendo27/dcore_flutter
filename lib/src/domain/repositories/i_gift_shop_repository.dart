part of 'repositories.dart';

abstract interface class IGiftShopRepository {
  Future<BaseResponseList<GiftMain>> fetchGiftShopList();
}
