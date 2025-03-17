part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class NotificationApi {
  @factoryMethod
  factory NotificationApi(@Named(DIKey.appDio) Dio dio) = _NotificationApi;

  @GET(AppEndpoint.getNotificationList)
  Future<BaseResponse<AppNotificationList>> fetchNotificationList();

  @GET(AppEndpoint.getNewFollowerNotificationDetail)
  Future<BaseResponse<BasePageBreak<AppNotification>>> fetchNewFollowerNotificationDetail(@Query('page') int page);

  @GET(AppEndpoint.getActivityNotificationDetail)
  Future<BaseResponse<BasePageBreak<AppNotification>>> fetchActivityNotificationDetail(@Query('page') int page);

  @GET(AppEndpoint.getSystemNotificationDetail)
  Future<BaseResponse<BasePageBreak<AppSystemNotification>>> fetchSystemNotificationDetail(@Query('page') int page);

  @GET(AppEndpoint.getSuggestUser)
  Future<BaseResponse<BasePageBreak<AppUser>>> fetchSuggestUser(@Query('page') int page);

  @POST(AppEndpoint.pushNotificationToSingleUser)
  Future<PushNotificationResponse> pushNotificationToSingleUser(@Body() Map<String, dynamic> message);
}
