part of '../models.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    @Default(0) int id,
    @Default('') String thumbnail,
    @Default([]) List<String> images,
    @Default(0) int discount,
    @Default('') String name,
    @Default(0) int sold,
    @Default(0) int price,
    @Default(0) int stock,
    @Default(0) int review,
    @Default(0) int totalRatings,
    @Default(0) double averageRating,
    @Default(0) int discountedPrice,
    @Default('') String deliveryTime,
    @Default('') String description,
    @Default(false) bool bookmarked,
    @Default([]) List<Attribute> attributes,
    @Default(false) bool isPinned,
    @Default(Store()) Store store,
    @Default(0) int cartId,
    @Default(0) int quantity,
    @Default([]) List<AttributeValue> variant,
    @Default('') String video,
    @Default('') String link,
    @Default('') String commissionValue,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
abstract class ProductDetail with _$ProductDetail {
  const factory ProductDetail({
    @Default(Product()) Product product,
    @Default([]) List<Voucher> vouchers,
    @Default([]) List<ProductReview> reviews,
    @Default([]) List<Post> posts,
    @Default([]) List<Product> products,
  }) = _ProductDetail;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => _$ProductDetailFromJson(json);
}

extension ProductX on Product {
  String get variantString {
    return variant.map((e) => e.value).join(', ');
  }

  int get totalPrice {
    return discountedPrice * quantity;
  }
}

extension ListProductX on List<Product> {
  List<StoreParam> get storeParams {
    List<StoreParam> storeParams = [];

    for (var product in this) {
      if (storeParams.isEmpty) {
        storeParams.add(StoreParam(
          storeId: product.store.id,
          items: [
            ProductParam(
              productId: product.id,
              quantity: product.quantity,
              cartId: product.cartId,
              attributeValues: product.variant.map((e) => e.value).toList(),
            )
          ],
        ));
        continue;
      }

      int index = storeParams.checkStoreExistInList(product);

      if (index != -1) {
        List<ProductParam> productParams = [...storeParams[index].items];
        productParams.add(ProductParam(
          productId: product.id,
          quantity: product.quantity,
          cartId: product.cartId,
          attributeValues: product.variant.map((e) => e.value).toList(),
        ));
        storeParams[index] = storeParams[index].copyWith(items: productParams);
        continue;
      }

      storeParams.add(StoreParam(
        storeId: product.store.id,
        items: [
          ProductParam(
            productId: product.id,
            quantity: product.quantity,
            cartId: product.cartId,
            attributeValues: product.variant.map((e) => e.value).toList(),
          )
        ],
      ));
    }

    return storeParams;
  }

  List<OrderOverviewStoreInfo> get orderOverviewStoreInfos {
    List<OrderOverviewStoreInfo> orderOverviewStoreInfos = [];

    for (var product in this) {
      int index = orderOverviewStoreInfos.checkStoreExistInList(product);

      if (index != -1) {
        List<Product> products = [...orderOverviewStoreInfos[index].items];
        products.add(product);
        orderOverviewStoreInfos[index] = orderOverviewStoreInfos[index].copyWith(items: products);
        continue;
      }

      orderOverviewStoreInfos.add(OrderOverviewStoreInfo(
        infor: product.store,
        items: [product],
      ));
    }

    return orderOverviewStoreInfos;
  }

  List<ProductParam> get productParams {
    return map((e) => ProductParam(
          productId: e.id,
          quantity: e.quantity,
          cartId: e.cartId,
          attributeValues: e.variant.map((e) => e.value).toList(),
        )).toList();
  }
}

extension ListStoreParamX on List<StoreParam> {
  int checkStoreExistInList(Product product) {
    return indexWhere((e) => e.storeId == product.store.id);
  }
}

extension StoreParamX on StoreParam {
  StoreParam addProductParam(ProductParam productParam) {
    return copyWith(items: [...items, productParam]);
  }
}
