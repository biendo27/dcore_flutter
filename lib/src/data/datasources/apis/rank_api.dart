part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class RankApi {
  @factoryMethod
  factory RankApi(@Named(DIKey.appDio) Dio dio) = _RankApi;

  @GET(AppEndpoint.rank)
  Future<BaseResponse<RankConfig>> fetchRank();

  @GET(AppEndpoint.rankHistory)
  Future<BaseResponseList<Rank>> fetchRankHistory();

  @GET(AppEndpoint.rankDetail)
  Future<BaseResponse<Rank>> fetchRankDetail(@Query('rankId') int rankId);
}
