part of '../models.dart';

@freezed
abstract class Live with _$Live {
  const factory Live({
    @Default(0) int id,
    @Default('') String roomId,
    @Default(null) DateTime? startAt,
    @Default(null) DateTime? endAt,
    @Default('') String title,
    @Default('') String description,
    @Default('') String thumbnail,
    @Default(LiveStatus.notStarted) LiveStatus status,
    @Default(0) int duration,
    @Default(0) int viewCount,
    @Default(null) DateTime? createdAt,
    @Default(0) int likesCount,
    @Default(0) int giftsCount,
    @Default(0) int soldProductsCount,
    @Default(LivePlatform()) LivePlatform livePlatform,
    @Default(LiveArea()) LiveArea area,
    @Default(AppUser()) AppUser user,
    @Default([]) List<Product> products,
    @Default(false) bool isGiveGift,
    @Default(0) int totalCoin,
    @Default(0) int totalOrder,
    @Default(0) int totalLike,
    @Default(LiveGiftType.coin) LiveGiftType typeGift,
    @Default(0) int coinGift,
    @Default(0) int wheelGift,
    @Default(Voucher()) Voucher voucherGift,
    @Default(Product()) Product productGift,
    @Default(0) int totalGiveCoin,
    @Default(0) int totalPurchasedOrder,
    @Default(0) int totalWheel,
    @Default(false) bool subscribed,
  }) = _Live;

  factory Live.fromJson(Map<String, dynamic> json) => _$LiveFromJson(json);
}

@freezed
abstract class LiveSocketData with _$LiveSocketData {
  const factory LiveSocketData({
    @Default(Live()) Live live,
    @Default('') String channel,
    @Default('') String socket,
  }) = _LiveSocketData;

  factory LiveSocketData.fromJson(Map<String, dynamic> json) => _$LiveSocketDataFromJson(json);
}

@freezed
abstract class LiveSocketUserReceiveGift with _$LiveSocketUserReceiveGift {
  const factory LiveSocketUserReceiveGift({
    @Default(Live()) Live live,
    @Default(AppUser()) AppUser user,
    @Default('') String channel,
    @Default('') String socket,
  }) = _LiveSocketUserReceiveGift;

  factory LiveSocketUserReceiveGift.fromJson(Map<String, dynamic> json) => _$LiveSocketUserReceiveGiftFromJson(json);
}

enum LiveStatus {
  @JsonValue('not_started')
  notStarted,
  @JsonValue('live')
  live,
  @JsonValue('completed')
  completed,
  @JsonValue('pending')
  pending,
  @JsonValue('canceled')
  canceled,
}

enum LiveGiftType {
  @JsonValue('coin')
  coin,
  @JsonValue('voucher')
  voucher,
  @JsonValue('product')
  product,
  @JsonValue('wheel')
  wheel;

  Widget get icon {
    return switch (this) {
      LiveGiftType.coin => AppAsset.images.coin.image(
          width: 14.sp,
          height: 14.sp,
        ),
      LiveGiftType.voucher => AppAsset.images.voucherXtra.image(
          width: 14.sp,
          height: 14.sp,
        ),
      LiveGiftType.product => AppAsset.images.spin.image(
          width: 14.sp,
          height: 14.sp,
        ),
      LiveGiftType.wheel => AppAsset.images.spin.image(
          width: 14.sp,
          height: 14.sp,
        ),
    };
  }
}

extension LiveExtension on Live {
  List<String> get productImages {
    List<String> result = [];
    for (var product in products) {
      result.addAll(product.images);
    }
    return result;
  }

  List<Product> get allProducts {
    List<Product> result = [];
    for (var product in products) {
      result.add(product);
    }
    return result;
  }

  bool get isUserCanGetGift {
    if (id == 0) return false;
    if (totalLike <= likesCount && totalCoin <= totalGiveCoin && totalOrder <= totalPurchasedOrder) return true;
    return false;
  }
}
