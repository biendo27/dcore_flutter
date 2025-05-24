part of '../models.dart';

@freezed
abstract class OrderProduct with _$OrderProduct {
  const factory OrderProduct({
    @Default(0) int id,
    @Default(Product()) Product product,
    @Default(0) int quantity,
    @Default(0) double price,
    @Default([]) List<AttributeValue> variant,
    @Default(0) double totalMoney,
    @Default(false) bool reviewed,
  }) = _OrderProduct;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => _$OrderProductFromJson(json);
}

extension OrderProductX on OrderProduct {
  String get variantString => variant.map((e) => e.value).join(', ');

  Product get productInfo => product.copyWith(
        quantity: quantity,
        variant: variant,
      );
}
