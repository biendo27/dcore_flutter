part of '../models.dart';

@freezed
abstract class Voucher with _$Voucher {
  const factory Voucher({
    @Default(0) int id,
    @Default(0) int voucherId,
    @Default('') String name,
    @Default(VoucherClassification.price) VoucherClassification classification,
    @Default('') String code,
    @Default(DiscountType.directly) DiscountType discountType,
    @Default(0) double discountValue,
    @Default(0) double discountCondition,
    @Default(0) double discountMax,
    @Default(0) double discountAmount,
    @Default(0) int stock,
    @Default(null) DateTime? expiredAt,
    @Default(AppUser()) AppUser from,
    @Default(true) bool isActive,
    @Default(false) bool received,
    @Default('') String image,
  }) = _Voucher;

  factory Voucher.fromJson(Map<String, dynamic> json) => _$VoucherFromJson(json);
}

enum DiscountType {
  @JsonValue('directly')
  directly,
  @JsonValue('percentage')
  percentage,
}

enum VoucherClassification {
  @JsonValue('price')
  price,
  @JsonValue('shipping')
  shipping,
}

extension VoucherExtension on Voucher {
  String get discountValueString => discountType == DiscountType.directly ? discountValue.shortCurrency : "${discountValue.formattedDecimal}%";

  String get discountMaxString => discountMax.shortCurrency;

  String displayTitle(BuildContext context) {
    if (discountType == DiscountType.percentage) return context.text.discountWithMaximum(discountValueString, discountMaxString);
    return '${context.text.decrease} ${discountValue.shortCurrency}';
  }
}
