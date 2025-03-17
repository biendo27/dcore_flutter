part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class ProfileApi {
  @factoryMethod
  factory ProfileApi(@Named(DIKey.appDio) Dio dio) = _ProfileApi;

  @GET(AppEndpoint.profile)
  Future<BaseResponse<AppUser>> fetchProfile(@Query('user_id') int userId);

  @GET(AppEndpoint.myProfile)
  Future<BaseResponse<AppUser>> fetchMyProfile();

  @POST(AppEndpoint.profileUpdate)
  Future<BaseResponse<AppUser>> updateProfile(@Body() AppUser user);

  @POST(AppEndpoint.updateLanguage)
  Future<BaseResponse> updateLanguage(@Part(name: 'language') String languageCode);

  @GET(AppEndpoint.userPost)
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserPost(@Query('user_id') int userId, @Query('page') int page);

  @GET(AppEndpoint.userBookmark)
  Future<BaseResponseList> fetchUserBookmark(@Query('user_id') int userId, @Query('type') BookmarkType bookmarkType);

  @GET(AppEndpoint.userPostBookmarkList)
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserPostBookmarkList(@Query('user_id') int userId, @Query('page') int page);

  @GET(AppEndpoint.userLikePost)
  Future<BaseResponse<BasePageBreak<Post>>> fetchUserLikePost(@Query('user_id') int userId, @Query('page') int page);

  @GET(AppEndpoint.userProductBookmarkList)
  Future<BaseResponse<BasePageBreak<Product>>> fetchUserProductBookmarkList(@Query('user_id') int userId, @Query('page') int page);

  @GET(AppEndpoint.userSoundBookmarkList)
  Future<BaseResponse<BasePageBreak<Sound>>> fetchUserSoundBookmarkList(@Query('user_id') int userId, @Query('page') int page);

  @GET(AppEndpoint.userFilterBookmarkList)
  Future<BaseResponse<BasePageBreak<MediaFilter>>> fetchUserFilterBookmarkList(@Query('user_id') int userId, @Query('page') int page);

  @POST(AppEndpoint.updateUserSocketId)
  Future<BaseResponse> updateUserSocketId(@Part(name: 'socket_id') String socketId);
}
