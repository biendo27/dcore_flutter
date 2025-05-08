part of '../blocs.dart';

@freezed
abstract class ReviewState with _$ReviewState {
  const factory ReviewState({
    @Default(false) bool isLoading,
    @Default(Product()) Product product,
    @Default(BasePageBreak()) BasePageBreak<ProductReview> reviews,
  }) = _ReviewState;

  factory ReviewState.initial() => ReviewState();
}
