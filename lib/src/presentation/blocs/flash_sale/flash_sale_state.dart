part of '../blocs.dart';

@freezed
abstract class FlashSaleState with _$FlashSaleState {
  const factory FlashSaleState({
    @Default(false) bool isLoading,
    @Default(StoreFlashSale()) StoreFlashSale currentFlashSale,
  }) = _FlashSaleState;

  factory FlashSaleState.initial() => FlashSaleState();
}
