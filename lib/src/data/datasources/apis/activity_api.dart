part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class ActivityApi {
  @factoryMethod
  factory ActivityApi(@Named(DIKey.appDio) Dio dio) = _ActivityApi;

  @GET(AppEndpoint.userOrder)
  Future<BaseResponseList> fetchOrder();

  @GET(AppEndpoint.searchHistory)
  Future<BaseResponseList> fetchSearchHistory();
}
