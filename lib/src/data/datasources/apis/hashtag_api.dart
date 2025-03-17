part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class HashtagApi {
  @factoryMethod
  factory HashtagApi(@Named(DIKey.appDio) Dio dio) = _HashtagApi;

  @GET(AppEndpoint.hashtag)
  Future<BaseResponse<BasePageBreak<HashTag>>> fetchHashtagList(@Query('page') int page, @Query('search') String search);
}
