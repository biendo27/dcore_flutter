part of '../blocs.dart';

@freezed
abstract class GiftState with _$GiftState {
  const factory GiftState({
    @Default(false) bool isLoading,
    @Default(GiftDataResponse()) GiftDataResponse giftList,
    @Default(Gift()) Gift currentGift,
    @Default(false) bool sort,
  }) = _GiftState;

  factory GiftState.initial() => GiftState();
  factory GiftState.fromJson(Map<String, dynamic> json) => _$GiftStateFromJson(json);
}

extension GiftStateExtension on GiftState {
  List<Gift> get giftDataList => giftList.gifts;
}
