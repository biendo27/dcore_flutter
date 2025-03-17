part of '../services.dart';

mixin MapConfig {
  static const String key = 'AIzaSyAEw-G_Ml5erKllOpD2dk_pTCXkNhAKuYo';
  static const String types = 'geocode';

  static const String baseMapUrl = 'https://maps.googleapis.com/maps/api/';

  static const String searchPlaceUrl = 'place/autocomplete/json?input={input}&types=$types&key=$key';

  static const String getPlaceUrl = 'place/details/json?place_id={placeId}&key=$key';

  static const String getDirectionUrl = 'directions/json?origin={origin}&destination={destination}&key=$key';

  static const String getPlaceDetailsUrl = 'place/nearbysearch/json?&location={lat},{lng}&radius={radius}&key=$key';

  static const String getMorePlaceDetailsUrl = 'place/nearbysearch/json?&pagetoken={token}&key=$key';

  // static Future<List<MapAutoCompleteResult>> searchPlaces(String searchInput) async => AppInjector.injector<MapRepository>().searchPlaces(searchInput);

  static Future<Map<String, dynamic>> getPlace(String? input) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$input&key=$key';

    var response = await Dio().get(url);

    var json = response.data;

    var results = json['result'] as Map<String, dynamic>;

    return results;
  }

  // static Future<RouteModel> getDirections(String origin, String destination) async => AppInjector.injector<MapRepository>().getDirections(origin, destination);

  static Future<dynamic> getPlaceDetails(LatLng coords, int radius) async {
    var lat = coords.latitude;
    var lng = coords.longitude;

    final String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=$lat,$lng&radius=$radius&key=$key';

    var response = await Dio().get(url);

    var json = response.data;

    return json;
  }

  static Future<dynamic> getMorePlaceDetails(String token) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&pagetoken=$token&key=$key';

    var response = await Dio().get(url);

    var json = response.data;

    return json;
  }
}

mixin MapService {
  static Set<Marker> markers = {};
  static Set<Polyline> polylines = {};
  static int markerIdCounter = 1;
  static int polylineIdCounter = 1;

  static gotoPlace(RouteModel route, Completer<GoogleMapController> completeController) async {
    final GoogleMapController controller = await completeController.future;

    controller.animateCamera(
        CameraUpdate.newLatLngBounds(LatLngBounds(southwest: LatLng(route.bounds_sw.lat, route.bounds_sw.lng), northeast: LatLng(route.bounds_ne.lat, route.bounds_ne.lng)), 25));

    setMarker(LatLng(route.start_location.lat, route.start_location.lng), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan));
    setMarker(LatLng(route.end_location.lat, route.end_location.lng));
  }

  static void setMarker(point, {BitmapDescriptor icon = BitmapDescriptor.defaultMarker}) {
    var counter = markerIdCounter++;

    final Marker marker = Marker(markerId: MarkerId('marker_$counter'), position: point, onTap: () {}, icon: icon);

    markers.add(marker);
  }

  static void setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$polylineIdCounter';

    polylineIdCounter++;

    polylines.add(Polyline(polylineId: PolylineId(polylineIdVal), width: 2, color: Colors.blue, points: points.map((e) => LatLng(e.latitude, e.longitude)).toList()));
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static setNearMarker(LatLng point) async {
    var counter = MapService.markerIdCounter++;

    // final Uint8List markerIcon = await getBytesFromAsset(AppAsset.icons.driver, 100);

    final Marker marker = Marker(
      markerId: MarkerId('marker_$counter'),
      position: point,
      onTap: () {},
      // icon: BitmapDescriptor.bytes(markerIcon),
    );

    MapService.markers.add(marker);
  }
}
