part of '../models.dart';

@freezed
abstract class ShopCartInfo with _$ShopCartInfo {
  const factory ShopCartInfo({
    @Default(0) int totalQuantity,
    @Default(Store()) Store store,
    @Default([]) List<Product> products,
  }) = _ShopCartInfo;

  factory ShopCartInfo.fromJson(Map<String, dynamic> json) => _$ShopCartInfoFromJson(json);
}

extension ShopCartInfoExtension on ShopCartInfo {
  bool isProductInStore(Product product) {
    return products.any((e) => e.id == product.id);
  }

  int getStoreIdFromProduct(Product product) {
    if (isProductInStore(product)) {
      return store.id;
    }
    return 0;
  }

  OrderOverviewStoreInfo toOrderOverviewStoreInfo(List<Product> products) {
    return OrderOverviewStoreInfo(
      infor: store,
      items: products,
    );
  }
}
