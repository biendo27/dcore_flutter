part of '../models.dart';

@freezed
abstract class GiftMain with _$GiftMain {
  const factory GiftMain({
    @Default(0) int id,
    @Default(Awards()) Awards award,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _GiftMain;

  factory GiftMain.fromJson(Map<String, dynamic> json) => _$GiftMainFromJson(json);
}

@freezed
abstract class GiftData with _$GiftData {
  const factory GiftData({
    @Default([]) List<GiftMain> data,
  }) = _GiftData;

  factory GiftData.fromJson(Map<String, dynamic> json) => _$GiftDataFromJson(json);
}
