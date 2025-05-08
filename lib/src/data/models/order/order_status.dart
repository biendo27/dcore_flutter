part of '../models.dart';

@freezed
abstract class OrderStatus with _$OrderStatus {
  const factory OrderStatus({
    @Default('') String name,
    @Default(UserOrderStatusType.pending) UserOrderStatusType code,
  }) = _OrderStatus;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => _$OrderStatusFromJson(json);
}

@freezed
abstract class OrderDeliveryStatus with _$OrderDeliveryStatus {
  const factory OrderDeliveryStatus({
    @Default('') String status,
    @Default('') String description,
    @Default(null) DateTime? createdAt,
  }) = _OrderDeliveryStatus;

  factory OrderDeliveryStatus.fromJson(Map<String, dynamic> json) => _$OrderDeliveryStatusFromJson(json);
}

enum UserOrderStatusType {
  @JsonValue('')
  all,
  @JsonValue('pending')
  pending,
  @JsonValue('awaiting_delivery')
  awaitingDelivery,
  @JsonValue('delivering')
  delivering,
  @JsonValue('success')
  success,
  @JsonValue('cancel')
  cancel;

  String get name {
    return switch (this) {
      UserOrderStatusType.all => '',
      UserOrderStatusType.pending => 'pending',
      UserOrderStatusType.awaitingDelivery => 'awaiting_delivery',
      UserOrderStatusType.delivering => 'delivering',
      UserOrderStatusType.success => 'success',
      UserOrderStatusType.cancel => 'cancel',
    };
  }

  String displayName(BuildContext context) {
    return switch (this) {
      UserOrderStatusType.all => context.text.all,
      UserOrderStatusType.pending => context.text.pendingTitle,
      UserOrderStatusType.awaitingDelivery => context.text.awaitingDelivery,
      UserOrderStatusType.delivering => context.text.delivering,
      UserOrderStatusType.success => context.text.complete,
      UserOrderStatusType.cancel => context.text.canceled,
    };
  }

  Color get statusColor {
    return switch (this) {
      UserOrderStatusType.all => AppCustomColor.greyF5,
      UserOrderStatusType.pending => AppCustomColor.orangeF5,
      UserOrderStatusType.awaitingDelivery => AppCustomColor.blue3C,
      UserOrderStatusType.delivering => AppCustomColor.orangeF5,
      UserOrderStatusType.success => AppCustomColor.green0F,
      UserOrderStatusType.cancel => AppCustomColor.redD0,
    };
  }
}
