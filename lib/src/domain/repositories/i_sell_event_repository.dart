part of 'repositories.dart';

abstract interface class ISellEventRepository {
  Future<BaseResponse<BasePageBreak<Event>>> getEvents(int page);
  Future<BaseResponse<Event>> getEventDetail(int eventId);
} 