part of '../models.dart';

@freezed
abstract class PackageResponse with _$PackageResponse {
  const factory PackageResponse({
    @Default(false) bool firstDeposit,
    @Default([]) List<Package> packages,
  }) = _PackageResponse;
  factory PackageResponse.fromJson(Map<String, dynamic> json) => _$PackageResponseFromJson(json);
}

@freezed
abstract class Package with _$Package {
  const factory Package({
    @Default(0) int id,
    @Default('') String inAppId,
    @Default('') String name,
    @Default('') String description,
    @Default('') String image,
    @Default(0) int price,
    @Default(0) int coin,
    @Default(0) int coinPlus,
  }) = _Package;

  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);
}
