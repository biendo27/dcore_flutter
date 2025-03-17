part of 'repositories.dart';

abstract interface class IMapRepository {
  Future<dynamic> searchPlaces(String input);
  Future<dynamic> getPlace(String placeId);
  Future<dynamic> getDirections(String origin, String destination);
  Future<dynamic> getPlaceDetails(double lat, double lng, int radius);
  Future<dynamic> getMorePlaceDetails(String token);
}
