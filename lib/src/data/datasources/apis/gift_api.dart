part of 'apis.dart';

@RestApi()
@lazySingleton
abstract class GiftApi {
  @factoryMethod
  factory GiftApi(@Named(DIKey.appDio) Dio dio) = _GiftApi;

  @GET(AppEndpoint.getGiftList)
  Future<BaseResponse<GiftDataResponse>> fetchGiftList(@Query('sort') bool sort);

  @POST(AppEndpoint.createGift)
  Future<BaseResponse> createGift(@Body() Map<String, dynamic> body);

  @POST(AppEndpoint.giveGift)
  Future<BaseResponse<GiveGiftResponse>> giveGift(@Body() Map<String, dynamic> body);
}
