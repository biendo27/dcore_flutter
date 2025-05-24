part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class LiveApi {
  @factoryMethod
  factory LiveApi(@Named(DIKey.appDio) Dio dio) = _LiveApi;

  @GET(AppEndpoint.liveList)
  Future<BaseResponse<BasePageBreak<Live>>> getLiveList(@Query('page') int page, @Query('search') String search);

  @GET(AppEndpoint.liveDetail)
  Future<BaseResponse<Live>> getLiveDetail(@Query('live_id') int id);

  @POST(AppEndpoint.createLive)
  Future<BaseResponse<Live>> createLive(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.cancelLive)
  Future<BaseResponse> cancelLive(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.startLive)
  Future<BaseResponse<Live>> startLive(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.endLive)
  Future<BaseResponse<Live>> endLive(@Part(name: 'live_id') int liveId);

  @POST(AppEndpoint.createLeaveRequest)
  Future<BaseResponse<BreakSchedule>> createLeaveRequest(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.getLeaveRequest)
  Future<BaseResponse<BasePageBreak<BreakSchedule>>> getLeaveRequest(@Query('page') int page);

  @GET(AppEndpoint.getLeaveRequestDetail)
  Future<BaseResponse<BreakSchedule>> getLeaveRequestDetail(@Query('leave_request_id') int id);

  @DELETE(AppEndpoint.deleteLeaveRequest)
  Future<BaseResponse> deleteLeaveRequest(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.createLiveRequest)
  Future<BaseResponse<LiveRequest>> createLiveRequest(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.getLiveRequest)
  Future<BaseResponse<BasePageBreak<LiveRequest>>> getLiveRequest(@Query('page') int page);

  @GET(AppEndpoint.getLiveRequestDetail)
  Future<BaseResponse<LiveRequest>> getLiveRequestDetail(@Query('leave_request_id') int id);

  @DELETE(AppEndpoint.deleteLiveRequest)
  Future<BaseResponse> deleteLiveRequest(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.livePlatforms)
  Future<BaseResponseList<LivePlatform>> getLivePlatforms();

  @GET(AppEndpoint.liveAreas)
  Future<BaseResponseList<LiveArea>> getLiveAreas();

  @GET(AppEndpoint.mySchedule)
  Future<BaseResponse<BasePageBreak<LiveSchedule>>> getMySchedule(@Query('page') int page);

  @GET(AppEndpoint.myNearestLive)
  Future<BaseResponse<Live>> getMyNearestLive();

  @GET(AppEndpoint.myScheduleDetail)
  Future<BaseResponse<Live>> getMyScheduleDetail(@Query('live_id') int id);

  @POST(AppEndpoint.updatePinProductToLive)
  Future<BaseResponse<Live>> updatePinProductToLive(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.updatePinCommentToLive)
  Future<BaseResponse<Comment>> updatePinCommentToLive(@Part(name: 'live_id') int liveId, @Part(name: 'comment_id') int commentId);

  @GET(AppEndpoint.liveBooth)
  Future<BaseResponse<LiveBooth>> getLiveBooth(@Query('live_id') int id);

  @POST(AppEndpoint.liveMarkAsRead)
  Future<BaseResponse> markAsRead(@Part(name: 'live_id') int id, @Part(name: 'device_token') String deviceToken);

  @GET(AppEndpoint.listComment)
  Future<BaseResponse<BasePageBreak<Comment>>> getListComment(@Query('live_id') int id, @Query('page') int page);

  @GET(AppEndpoint.loadOldComment)
  Future<BaseResponseList<Comment>> loadOldComment(@Query('comment_id') int commentId);

  @POST(AppEndpoint.createComment)
  Future<BaseResponse<Comment>> createComment(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.liveLike)
  Future<BaseResponse> liveLike(@Part(name: 'live_id') int id);

  @POST(AppEndpoint.leaveLive)
  Future<BaseResponse> leaveLive(@Query('live_id') int id);

  @GET(AppEndpoint.liveProductOther)
  Future<BaseResponse<BasePageBreak<Product>>> getLiveProductOther(@Query('live_id') int id, @Query('page') int page);

  @GET(AppEndpoint.liveMission)
  Future<BaseResponse<BasePageBreak<LiveMission>>> getLiveMission(@Query('live_id') int id, @Query('page') int page);

  @POST(AppEndpoint.liveMissionReceive)
  Future<BaseResponse> receiveLiveMission(@Part(name: 'mission_live_id') int missionLiveId);

  @GET(AppEndpoint.liveExtraInfo)
  Future<BaseResponse<LiveExtraInfo>> getLiveExtraInfo(@Query('live_id') int liveId);

  @GET(AppEndpoint.liveRandom)
  Future<BaseResponse<AppUser>> getLiveRandom(@Query('live_id') int liveId);

  @GET(AppEndpoint.liveEventList)
  Future<BaseResponse<BasePageBreak<Live>>> getLiveEventList(@Query('page') int page);

  @POST(AppEndpoint.liveEventSubscribe)
  Future<BaseResponse<Live>> liveEventSubscribe(@Part(name: 'live_id') int liveId);

  @GET(AppEndpoint.generateAgoraToken)
  Future<BaseResponse<String>> generateAgoraToken(@Query('room_id') String roomId);
}
