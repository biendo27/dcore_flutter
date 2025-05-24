part of '../models.dart';

@freezed
abstract class ProductService with _$ProductService {
  const factory ProductService({
    @Default('') String easyPayment,
    @Default('') String cancelOrdersEasily,
    @Default('') String supportTeam,
  }) = _ProductService;

  factory ProductService.fromJson(Map<String, dynamic> json) => _$ProductServiceFromJson(json);
}

enum ProductServiceType {
  @JsonValue('easy_payment')
  easyPayment,
  @JsonValue('cancel_orders_easily')
  cancelOrdersEasily,
  @JsonValue('support_team')
  supportTeam;

  String get name {
    return switch (this) {
      ProductServiceType.easyPayment => 'easy_payment',
      ProductServiceType.cancelOrdersEasily => 'cancel_orders_easily',
      ProductServiceType.supportTeam => 'support_team'
    };
  }
}
