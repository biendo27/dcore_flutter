part of '../models.dart';

@freezed
abstract class UsageTerm with _$UsageTerm {
  const factory UsageTerm({
    @Default(VoucherData()) VoucherData voucher,
    @Default('') String term,
  }) = _UsageTerm;

  factory UsageTerm.fromJson(Map<String, dynamic> json) => _$UsageTermFromJson(json);
}

@freezed
abstract class VoucherData with _$VoucherData {
  const factory VoucherData({
    @Default([]) List<String> detail,
    @Default(null) DateTime? expiredAt,
    @Default('') String limit,
    @Default('') String stock,
  }) = _VoucherData;

  factory VoucherData.fromJson(Map<String, dynamic> json) => _$VoucherDataFromJson(json);
}
