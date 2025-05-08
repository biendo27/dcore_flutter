part of '../models.dart';

@freezed
abstract class AffiliateInfo with _$AffiliateInfo {
  const factory AffiliateInfo({
    @Default(0) int id,
    @Default("") String name,
    @Default("") String phone,
    @Default("") String email,
    @Default("") String address,
    @Default("") String identityCard,
    @Default("") String taxCode,
    @Default("") String frontPhotoIdentityCard,
    @Default("") String backPhotoIdentityCard,
    @Default("") String status,
    @Default("") String createdAtFormat,
    @Default(Nation()) Nation nationalId,
    @Default(City()) City cityId,
    @Default(District()) District districtId,
    @Default(Ward()) Ward wardId,
  }) = _AffiliateInfo;

  factory AffiliateInfo.fromJson(Map<String, dynamic> json) => _$AffiliateInfoFromJson(json);
}
