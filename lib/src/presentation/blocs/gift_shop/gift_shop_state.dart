part of '../blocs.dart';

@freezed
abstract class GiftShopState with _$GiftShopState {
  const factory GiftShopState({
    @Default(false) bool isLoading, // Trạng thái tải dữ liệu
    @Default([]) List<GiftMain> data, // Danh sách GiftData
  }) = _GiftShopState;

  factory GiftShopState.initial() => const GiftShopState();
}
