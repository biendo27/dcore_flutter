part of '../models.dart';

@freezed
abstract class Store with _$Store {
  const factory Store({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String address,
    @Default('') String image,
    @Default('') String user,
    @Default(AppUser()) AppUser user2,
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}

extension StoreX on Store {
  OrderOverviewStoreInfo toOrderOverviewStoreInfo(List<Product> products) {
    return OrderOverviewStoreInfo(infor: this, items: products);
  }
}
