part of 'repositories.dart';

abstract interface class 
IGiftRepository {
  Future<BaseResponse<GiftDataResponse>> fetchGiftList(bool sort);
  Future<BaseResponse> createGift(Map<String, dynamic> body);
  Future<BaseResponse<GiveGiftResponse>> giveGift(Map<String, dynamic> body);
}
