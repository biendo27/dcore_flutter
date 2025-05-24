part of '../models.dart';

@freezed
abstract class UserCart with _$UserCart {
  const factory UserCart({
    @Default(0) int totalMoney,
    @Default(0) int totalQuantity,
    @Default([]) List<ShopCartInfo> details,
  }) = _UserCart;

  factory UserCart.fromJson(Map<String, dynamic> json) => _$UserCartFromJson(json);
}

extension UserCartX on UserCart {
  int get allProductLength => details.fold(0, (oldSum, d) => oldSum + d.products.length);
}
