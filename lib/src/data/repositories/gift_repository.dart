part of 'repositories.dart';

@LazySingleton(as: IGiftRepository)
class GiftRepository with DataStateConvertible implements IGiftRepository {
  final GiftApi _giftApi;
  GiftRepository(this._giftApi);

  @override
  Future<BaseResponse<GiftDataResponse>> fetchGiftList(bool sort) {
    return request(apiCall: () => _giftApi.fetchGiftList(sort));
  }

  @override
  Future<BaseResponse> createGift(Map<String, dynamic> body) {
    return request(apiCall: () => _giftApi.createGift(body));
  }

  @override
  Future<BaseResponse<GiveGiftResponse>> giveGift(Map<String, dynamic> body) {
    return request(apiCall: () => _giftApi.giveGift(body));
  }
}
