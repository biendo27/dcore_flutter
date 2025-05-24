part of 'repositories.dart';

@LazySingleton(as: ISellEventRepository)
class SellEventRepository with DataStateConvertible implements ISellEventRepository {
  final SellEventApi _sellEventApi;
  SellEventRepository(this._sellEventApi);

  @override
  Future<BaseResponse<BasePageBreak<Event>>> getEvents(int page) {
    return request(apiCall: () => _sellEventApi.getEvents(page));
  }

  @override
  Future<BaseResponse<Event>> getEventDetail(int eventId) {
    return request(apiCall: () => _sellEventApi.getEventDetail(eventId));
  }
} 