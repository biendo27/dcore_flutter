part of '../blocs.dart';

@freezed
class OrderReviewState with _$OrderReviewState {
  const factory OrderReviewState({
    @Default(false) bool isLoading,
    @Default(BasePageBreak<ProductReview>()) BasePageBreak<ProductReview> userReviews,
    @Default(BasePageBreak<OrderProduct>()) BasePageBreak<OrderProduct> productPendingReviews,
  }) = _OrderReviewState;

  factory OrderReviewState.initial() => OrderReviewState();
}
