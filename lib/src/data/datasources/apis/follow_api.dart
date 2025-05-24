part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class FollowApi {
  @factoryMethod
  factory FollowApi(@Named(DIKey.appDio) Dio dio) = _FollowApi;

  @GET(AppEndpoint.userList)
  Future<BaseResponse<BasePageBreak<AppUser>>> fetchUserList(
    @Query('user_id') int userId,
    @Query('type') UserType type,
    @Query('search') String search,
    @Query('page') int page,
  );

  @POST(AppEndpoint.updateUserFollow)
  Future<BaseResponse<AppUser>> updateUserFollow(@Part(name: 'user_id') int userId);

  @POST(AppEndpoint.removeSuggestion)
  Future<BaseResponse> removeSuggestion(@Part(name: 'user_id') int userId);
}
