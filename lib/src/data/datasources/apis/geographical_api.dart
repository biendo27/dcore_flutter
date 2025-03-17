part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class GeographicalApi {
  @factoryMethod
  factory GeographicalApi(@Named(DIKey.appDio) Dio dio) = _GeographicalApi;

  @GET(AppEndpoint.nation)
  Future<BaseResponseList> fetchNation();

  @GET(AppEndpoint.city)
  Future<BaseResponseList> fetchCity(@Query('nationId') int nationId);

  @GET(AppEndpoint.district)
  Future<BaseResponseList> fetchDistrict(@Query('cityId') int cityId);

  @GET(AppEndpoint.ward)
  Future<BaseResponseList> fetchWard(@Query('districtId') int districtId);
}
