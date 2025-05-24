part of '../helpers.dart';


class DefaultInt extends JsonConverter<int, dynamic> {
  const DefaultInt();

  @override
  int fromJson(dynamic json) {
    if (json == null) return 0;
    if (json is int) return json;
    return int.parse(json);
  }

  @override
  int toJson(int object) => object;
}

class DefaultDouble extends JsonConverter<double, dynamic> {
  const DefaultDouble();

  @override
  double fromJson(dynamic json) {
    if (json == null) return 0.0;
    if (json is double) return json;
    return double.parse(json);
  }

  @override
  double toJson(double object) => object;
}

