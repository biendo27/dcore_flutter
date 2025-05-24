part of '../models.dart';

@freezed
abstract class StoreHome with _$StoreHome {
  const factory StoreHome({
    @Default([]) List<StoreBanner> banners,
    @Default(StoreFlashSale()) StoreFlashSale flashSale,
    @Default([]) List<StoreCategory> categories,
    @Default([]) List<Event> events,
    @Default([]) List<Product> products,
  }) = _StoreHome;

  factory StoreHome.fromJson(Map<String, dynamic> json) => _$StoreHomeFromJson(json);
}
