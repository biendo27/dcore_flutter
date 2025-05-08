part of '../models.dart';

@freezed
abstract class Gift with _$Gift {
  const factory Gift({
    @Default(0) int id,
    @Default('') String name,
    @Default(0) int coin,
    @Default('') String image,
    @Default('') String effect,
    @Default(null) DateTime? createdAt,
  }) = _Gift;

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);
}

@freezed
abstract class GiftDataResponse with _$GiftDataResponse {
  const factory GiftDataResponse({
    @Default([]) List<Gift> gifts,
    @Default(0) int userTotalCoin,
  }) = _GiftDataResponse;

  factory GiftDataResponse.fromJson(Map<String, dynamic> json) => _$GiftDataResponseFromJson(json);
}

@freezed
abstract class GiveGiftResponse with _$GiveGiftResponse {
  const factory GiveGiftResponse({
    @Default(Gift()) Gift gift,
    @Default(Transaction()) Transaction transaction,
  }) = _GiveGiftResponse;

  factory GiveGiftResponse.fromJson(Map<String, dynamic> json) => _$GiveGiftResponseFromJson(json);
}

enum GiftType {
  @JsonValue('post')
  post,
  @JsonValue('live')
  live;
}

@freezed
abstract class LiveGiftSocketData with _$LiveGiftSocketData {
  const factory LiveGiftSocketData({
    @Default(Gift()) Gift gift,
    @Default(Live()) Live live,
    @Default('') String channel,
    @Default('') String socket,
  }) = _LiveGiftSocketData;

  factory LiveGiftSocketData.fromJson(Map<String, dynamic> json) => _$LiveGiftSocketDataFromJson(json);
}
