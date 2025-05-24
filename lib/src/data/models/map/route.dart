// ignore_for_file: non_constant_identifier_names

part of '../models.dart';

class RouteModel {
  PositionModel bounds_ne;
  PositionModel bounds_sw;
  PositionModel start_location;
  PositionModel end_location;
  String points;
  List<PointLatLng> points_decoded;
  RouteModel({
    PositionModel? bounds_ne,
    PositionModel? bounds_sw,
    PositionModel? start_location,
    PositionModel? end_location,
    this.points = '',
    this.points_decoded = const [],
  })  : bounds_ne = bounds_ne ?? PositionModel(),
        bounds_sw = bounds_sw ?? PositionModel(),
        start_location = start_location ?? PositionModel(),
        end_location = end_location ?? PositionModel();

  RouteModel copyWith({
    PositionModel? bounds_ne,
    PositionModel? bounds_sw,
    PositionModel? start_location,
    PositionModel? end_location,
    String? points,
    List<PointLatLng>? points_decoded,
  }) {
    return RouteModel(
      bounds_ne: bounds_ne ?? this.bounds_ne,
      bounds_sw: bounds_sw ?? this.bounds_sw,
      start_location: start_location ?? this.start_location,
      end_location: end_location ?? this.end_location,
      points: points ?? this.points,
      points_decoded: points_decoded ?? this.points_decoded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bounds_ne': bounds_ne.toMap(),
      'bounds_sw': bounds_sw.toMap(),
      'start_location': start_location.toMap(),
      'end_location': end_location.toMap(),
      'points': points,
      'points_decoded': points_decoded.map((x) => x).toList(),
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      bounds_ne: PositionModel.fromMap(map['routes'][0]['bounds']['northeast'] ?? {}),
      bounds_sw: PositionModel.fromMap(map['routes'][0]['bounds']['southwest'] ?? {}),
      start_location: PositionModel.fromMap(map['routes'][0]['legs'][0]['start_location'] ?? {}),
      end_location: PositionModel.fromMap(map['routes'][0]['legs'][0]['end_location'] ?? {}),
      points: map['routes'][0]['overview_polyline']['points'] ?? '',
      points_decoded: PolylinePoints().decodePolyline(map['routes'][0]['overview_polyline']['points'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteModel.fromJson(String source) => RouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Route(bounds_ne: $bounds_ne, bounds_sw: $bounds_sw, start_location: $start_location, end_location: $end_location, points: $points, points_decoded: $points_decoded)';
  }

  @override
  bool operator ==(covariant RouteModel other) {
    if (identical(this, other)) return true;

    return other.bounds_ne == bounds_ne &&
        other.bounds_sw == bounds_sw &&
        other.start_location == start_location &&
        other.end_location == end_location &&
        other.points == points &&
        listEquals(other.points_decoded, points_decoded);
  }

  @override
  int get hashCode {
    return bounds_ne.hashCode ^ bounds_sw.hashCode ^ start_location.hashCode ^ end_location.hashCode ^ points.hashCode ^ points_decoded.hashCode;
  }
}

class PositionModel {
  double lat;
  double lng;
  PositionModel({
    this.lat = 0,
    this.lng = 0,
  });

  PositionModel copyWith({
    double? lat,
    double? lng,
  }) {
    return PositionModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory PositionModel.fromMap(Map<String, dynamic> map) {
    return PositionModel(
      lat: map['lat'] ?? 0,
      lng: map['lng'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionModel.fromJson(String source) => PositionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Position(lat: $lat, lng: $lng)';

  @override
  bool operator ==(covariant PositionModel other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}

class LocationModel {
  double lat;
  double long;
  String driverId;
  String createdAt;
  String updatedAt;
  LocationModel({
    this.lat = 0,
    this.long = 0,
    this.driverId = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  LocationModel copyWith({
    double? lat,
    double? long,
    String? driverId,
    String? createdAt,
    String? updatedAt,
  }) {
    return LocationModel(
      lat: lat ?? this.lat,
      long: long ?? this.long,
      driverId: driverId ?? this.driverId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'long': long,
      'driverId': driverId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      lat: map['lat'] ?? 0,
      long: map['long'] ?? 0,
      driverId: map['driverId'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(lat: $lat, long: $long, driverId: $driverId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.long == long && other.driverId == driverId && other.createdAt == createdAt && other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return lat.hashCode ^ long.hashCode ^ driverId.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
