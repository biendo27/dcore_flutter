part of '../blocs.dart';

@freezed
abstract class InAppState with _$InAppState {
  const factory InAppState({
    @Default(false) bool isAvailable,
    @Default(false) bool isLoading,
    @Default([]) List<ProductDetails> products,
    @Default([]) List<PurchaseDetails> purchases,
    @Default(null) String? error,
    @Default({}) Map<String, int> consumableBalance,
    @Default('') String packageId,
  }) = _InAppState;

  factory InAppState.initial() => const InAppState();
}
