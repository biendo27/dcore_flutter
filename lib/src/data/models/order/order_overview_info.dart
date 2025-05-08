part of '../models.dart';

@freezed
abstract class OrderOverviewInfo with _$OrderOverviewInfo {
  const factory OrderOverviewInfo({
    @Default(UserBillingAddress()) UserBillingAddress billingAddress,
    @Default([]) List<OrderOverviewStoreInfo> stores,
    @Default(PaymentMethod()) PaymentMethod paymentMethods,
    @Default([]) List<Voucher> vouchers,
    @Default(0) int coin,
    @Default(0) int actualCoinsUsed,
    @Default(0) int changeCoinToMoney,
    @Default(0) int totalQuantity,
    @Default(0) int totalPrice,
    @Default(0) int totalShippingFee,
    @Default(0) int totalShippingVoucher,
    @Default(0) int totalVoucher,
    @Default(0) int totalMoney,
    @Default(0) int saveMoney,
    @Default(false) bool isUseCoin,
  }) = _OrderOverviewInfo;

  factory OrderOverviewInfo.fromJson(Map<String, dynamic> json) => _$OrderOverviewInfoFromJson(json);
}

@freezed
abstract class OrderOverviewStoreInfo with _$OrderOverviewStoreInfo {
  const factory OrderOverviewStoreInfo({
    @Default(0) int totalMoney,
    @Default(0) int totalQuantity,
    @Default([]) List<Product> items,
    @Default(0) int totalPrice,
    @Default(Voucher()) Voucher storeVoucher,
    @Default(Voucher()) Voucher shippingVoucher,
    @Default(Voucher()) Voucher orderVoucher,
    @Default(Store()) Store infor,
    @Default('') String note,
    @Default(ShippingMethod()) ShippingMethod shippingMethod,
  }) = _OrderOverviewStoreInfo;

  factory OrderOverviewStoreInfo.fromJson(Map<String, dynamic> json) => _$OrderOverviewStoreInfoFromJson(json);
}

extension OrderOverviewInfoX on OrderOverviewInfo {
  OrderOverviewParam toOrderOverviewParam() {
    int orderVoucherId = vouchers.firstWhere((e) => e.id != 0 && e.classification == VoucherClassification.price, orElse: () => Voucher()).id;
    return OrderOverviewParam(
      billingAddressId: billingAddress.id,
      stores: stores.map((e) => e.toStoreParam).toList(),
      paymentMethodId: paymentMethods.id,
      orderVoucherId: orderVoucherId,
      isUseCoin: isUseCoin,
    );
  }
}

extension OrderOverviewStoreInfoX on OrderOverviewStoreInfo {
  StoreParam get toStoreParam {
    int voucherId = storeVoucher.id == 0 ? storeVoucher.voucherId : storeVoucher.id;
    int shippingVoucherId = shippingVoucher.id == 0 ? shippingVoucher.voucherId : shippingVoucher.id;
    return StoreParam(
      storeId: infor.id,
      note: note,
      voucherId: voucherId,
      shippingVoucherId: shippingVoucherId,
      items: items.productParams,
    );
  }
}

extension OrderOverviewStoreInfoListX on List<OrderOverviewStoreInfo> {
  int checkStoreExistInList(Product product) {
    return indexWhere((e) => e.infor.id == product.store.id);
  }
}
