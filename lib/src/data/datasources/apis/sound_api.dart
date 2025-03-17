part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class SoundApi {
  @factoryMethod
  factory SoundApi(@Named(DIKey.appDio) Dio dio) = _SoundApi;

  @POST(AppEndpoint.createSound)
  Future<BaseResponse<Sound>> createSound(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.soundBookmarked)
  Future<BaseResponse<BasePageBreak<Sound>>> fetchSoundBookmarked(@Query('search') String search, @Query('page') int page);

  @GET(AppEndpoint.soundSuggestedList)
  Future<BaseResponse<BasePageBreak<Sound>>> fetchSoundSuggestedList(@Query('search') String search, @Query('page') int page);

  @GET(AppEndpoint.soundDetail)
  Future<BaseResponse<Sound>> fetchSoundDetail(@Query('sound_id') int soundId);

  @POST(AppEndpoint.updateBookmarkSound)
  Future<BaseResponse> updateBookmarkSound(@Part(name: 'sound_id') int soundId);
}
