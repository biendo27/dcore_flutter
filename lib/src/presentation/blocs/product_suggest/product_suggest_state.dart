part of '../blocs.dart';

@freezed
abstract class ProductSuggestState with _$ProductSuggestState {
  const factory ProductSuggestState({
    @Default(false) bool isLoading,
    @Default([]) List<Product> products,
  }) = _ProductSuggestState;

  factory ProductSuggestState.initial() => ProductSuggestState();
}
