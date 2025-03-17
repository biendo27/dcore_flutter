part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class BillingAddressApi {
  @factoryMethod
  factory BillingAddressApi(@Named(DIKey.appDio) Dio dio) = _BillingAddressApi;

  @GET(AppEndpoint.billingAddress)
  Future<BaseResponseList<UserBillingAddress>> fetchBillingAddress();

  @POST(AppEndpoint.billingAddressCreate)
  Future<BaseResponse> createBillingAddress(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.billingAddressUpdate)
  Future<BaseResponse> updateBillingAddress(@Body() Map<String, dynamic> body);

  @GET(AppEndpoint.nationList)
  Future<BaseResponseList<Nation>> fetchNationList();

  @GET(AppEndpoint.cityList)
  Future<BaseResponseList<City>> fetchCityList(@Query('national_id') int nationId);

  @GET(AppEndpoint.districtList)
  Future<BaseResponseList<District>> fetchDistrictList(@Query('city_id') int cityId);

  @GET(AppEndpoint.wardList)
  Future<BaseResponseList<Ward>> fetchWardList(@Query('district_id') int districtId);
}
