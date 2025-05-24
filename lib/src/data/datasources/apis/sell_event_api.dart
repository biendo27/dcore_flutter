part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class SellEventApi {
  @factoryMethod
  factory SellEventApi(@Named(DIKey.appDio) Dio dio) = _SellEventApi;

  @GET(AppEndpoint.sellEvent)
  Future<BaseResponse<BasePageBreak<Event>>> getEvents(@Query('page') int page);

  @GET(AppEndpoint.sellEventDetail)
  Future<BaseResponse<Event>> getEventDetail(@Query('event_id') int eventId);
}
