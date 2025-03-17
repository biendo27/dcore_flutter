part of 'apis.dart';

@RestApi(baseUrl: MapConfig.baseMapUrl)
@lazySingleton
abstract class MapApi {
  @factoryMethod
  factory MapApi(@Named(DIKey.thirdPartyDio) Dio dio) = _MapApi;

  @GET(MapConfig.searchPlaceUrl)
  Future<HttpResponse<dynamic>> searchPlaces(@Path('input') String input);

  @GET(MapConfig.getPlaceUrl)
  Future<HttpResponse<dynamic>> getPlace(@Path('placeId') String placeId);

  @GET(MapConfig.getDirectionUrl)
  Future<HttpResponse<dynamic>> getDirections(@Path('origin') String origin, @Path('destination') String destination);

  @GET(MapConfig.getPlaceDetailsUrl)
  Future<HttpResponse<dynamic>> getPlaceDetails(@Path('lat') double lat, @Path('lng') double lng, @Path('radius') int radius);

  @GET(MapConfig.getMorePlaceDetailsUrl)
  Future<HttpResponse<dynamic>> getMorePlaceDetails(@Path('token') String token);
}
