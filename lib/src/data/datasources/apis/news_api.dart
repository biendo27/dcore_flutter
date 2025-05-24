part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class NewsApi {
  @factoryMethod
  factory NewsApi(@Named(DIKey.appDio) Dio dio) = _NewsApi;

  @GET(AppEndpoint.getNewsDetail)
  Future<BaseResponse<AppNews>> getNewsDetail(@Query('news_id') int newsId);
}
