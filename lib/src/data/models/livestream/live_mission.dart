part of '../models.dart';

@freezed
abstract class LiveMission with _$LiveMission {
  const factory LiveMission({
    @Default(0) int id,
    @Default(Mission()) Mission mission,
    @Default(0) int quantity,
    @Default(0) int coin,
    @Default(0) int wheel,
    @Default('') String note,
    @Default(Voucher()) Voucher voucher,
    @Default(Product()) Product product,
    @Default(0) int progress,
    @Default(false) bool status,
    @Default(false) bool isReceive,
    @Default(LiveGiftType.coin) LiveGiftType type,
  }) = _LiveMission;

  factory LiveMission.fromJson(Map<String, dynamic> json) => _$LiveMissionFromJson(json);
}

@freezed
abstract class Mission with _$Mission {
  const factory Mission({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String image,
    @Default(0) int coin,
    @Default('') String code,
    @Default('') String description,
    @Default(0) int status,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default('') String createdAtFormat,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) => _$MissionFromJson(json);
}
