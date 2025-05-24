part of '../models.dart';

@freezed
abstract class AffiliateRequest with _$AffiliateRequest {
  const factory AffiliateRequest({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String phone,
    @Default('') String email,
    @Default('') String address,
    @Default(Nation()) Nation nationalId,
    @Default(City()) City cityId,
    @Default(District()) District districtId,
    @Default(Ward()) Ward wardId,
    @Default('') String identityCard,
    @Default('') String taxCode,
    @Default('') String frontPhotoIdentityCard,
    @Default('') String backPhotoIdentityCard,
    @Default('') String status,
    @Default('') String createdAtFormat,
  }) = _AffiliateRequest;

  factory AffiliateRequest.fromJson(Map<String, dynamic> json) => _$AffiliateRequestFromJson(json);
}
