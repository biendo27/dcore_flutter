part of 'apis.dart';

@RestApi(baseUrl: BaseURL.moderation)
@lazySingleton
abstract class ModerationApi {
  @factoryMethod
  factory ModerationApi(@Named(DIKey.thirdPartyDio) Dio dio) = _ModerationApi;

  @POST(ModerationEndpoint.checkVideoBelowOneMinute)
  @MultiPart()
  Future<ModerationResponse> checkVideoBelowOneMinute(
    @Part(name: 'media') File video,
    @Part(name: 'models') String models,
    @Part(name: 'api_user') int apiUser,
    @Part(name: 'api_secret') String apiSecret,
  );

  @POST(ModerationEndpoint.checkVideoAboveOneMinute)
  @MultiPart()
  Future<ModerationResponse> checkVideoAboveOneMinute(
    @Part(name: 'media') File video,
    @Part(name: 'models') String models,
    @Part(name: 'api_user') int apiUser,
    @Part(name: 'api_secret') String apiSecret,
  );
}
