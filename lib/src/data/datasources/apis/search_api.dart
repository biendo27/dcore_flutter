part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class SearchApi {
  @factoryMethod
  factory SearchApi(@Named(DIKey.appDio) Dio dio) = _SearchApi;

  @GET(AppEndpoint.userSearchHistory)
  Future<BaseResponse<SearchHistory>> fetchSearchHistory();

  @GET(AppEndpoint.listKeyword)
  Future<BaseResponseList<SearchKeyword>> fetchListKeyword(@Query('keyword') String keyword);

  @POST(AppEndpoint.saveKeywordHistory)
  Future<BaseResponse> saveKeywordHistory(@Part(name: 'keyword') String keyword);

  @DELETE(AppEndpoint.removeKeywordHistory)
  Future<BaseResponse> removeKeywordHistory(@Body() Map<String, dynamic> body);
}
