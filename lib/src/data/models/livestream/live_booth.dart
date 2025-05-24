part of '../models.dart';

@freezed
abstract class LiveBooth with _$LiveBooth {
  const factory LiveBooth({
    @Default(AppUser()) AppUser user,
    @Default([]) List<Product> products,
    @Default([]) List<Voucher> vouchers,
  }) = _LiveBooth;

  factory LiveBooth.fromJson(Map<String, dynamic> json) => _$LiveBoothFromJson(json);
}
