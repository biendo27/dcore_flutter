part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class LiveCensorApi {
  @factoryMethod
  factory LiveCensorApi(@Named(DIKey.appDio) Dio dio) = _LiveCensorApi;

  @GET(AppEndpoint.liveCensorForm)
  Future<BaseResponseList<LiveCensorForm>> getLiveCensorForm(@Query('live_id') int liveId);

  @POST(AppEndpoint.liveCensorSave)
  Future<BaseResponse<UserLiveCensor>> saveLiveCensor(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.liveCensorResultUser)
  Future<BaseResponse<UserLiveCensor>> getLiveCensorResult(@Query('live_id') int liveId);
}
