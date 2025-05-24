part of '../services.dart';

mixin GeolocatorService {
  static Future<dynamic> init() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      await Geolocator.getCurrentPosition();
    }
  }

  static Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  static void getLivePosition({
    required Function(Position) onPositionChanged,
    required Function(dynamic) onError,
    required Function() onDone,
  }) async {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      // timeLimit: Duration(seconds: 10),
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) => onPositionChanged(position),
      onError: (dynamic error) => onError(error),
      onDone: onDone,
    );
  }

  static double distanceBetween(Position position1, Position position2) {
    return Geolocator.distanceBetween(
      position1.latitude,
      position1.longitude,
      position2.latitude,
      position2.longitude,
    );
  }
}
