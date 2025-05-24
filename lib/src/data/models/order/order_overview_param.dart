part of '../models.dart';

@freezed
abstract class OrderOverviewParam with _$OrderOverviewParam {
  const factory OrderOverviewParam({
    @Default(0) int billingAddressId,
    @Default([]) List<StoreParam> stores,
    @Default(0) int paymentMethodId,
    @Default(0) int orderVoucherId,
    @Default(false) bool isUseCoin,
  }) = _OrderOverviewParam;

  factory OrderOverviewParam.fromJson(Map<String, dynamic> json) => _$OrderOverviewParamFromJson(json);
}

@freezed
abstract class StoreParam with _$StoreParam {
  const factory StoreParam({
    @Default(0) int storeId,
    @Default('') String note,
    @Default(0) int voucherId,
    @Default(0) int shippingVoucherId,
    @Default([]) List<ProductParam> items,
  }) = _StoreParam;

  factory StoreParam.fromJson(Map<String, dynamic> json) => _$StoreParamFromJson(json);
}

@freezed
abstract class ProductParam with _$ProductParam {
  const factory ProductParam({
    @Default(0) int productId,
    @Default(0) int quantity,
    @Default(0) int cartId,
    @Default([]) List<String> attributeValues,
  }) = _ProductParam;

  factory ProductParam.fromJson(Map<String, dynamic> json) => _$ProductParamFromJson(json);
}

extension ProductParamExtension on ProductParam {
  ProductParam copyWith({int? quantity}) => ProductParam(
        productId: productId,
        quantity: quantity ?? this.quantity,
        cartId: cartId,
        attributeValues: attributeValues,
      );
}

extension StoreParamExtension on StoreParam {
  // StoreParam fromStore(Store store) => copyWith(items: store.items.map((e) => e.toParam()).toList());
}
