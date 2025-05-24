part of '../models.dart';

@freezed
abstract class OrderReview with _$OrderReview {
  const factory OrderReview({
    @Default(0) int id,
  }) = _OrderReview;

  factory OrderReview.fromJson(Map<String, dynamic> json) => _$OrderReviewFromJson(json);
}
