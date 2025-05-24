part of '../models.dart';

@freezed
abstract class ProductReview with _$ProductReview {
  const factory ProductReview({
    @Default(AppUser()) AppUser user,
    @Default(0) double rating,
    @Default([]) List<String> images,
    @Default(Product()) product,
    @Default('') String content,
    @Default(null) DateTime? createdAt,
  }) = _ProductReview;

  factory ProductReview.fromJson(Map<String, dynamic> json) => _$ProductReviewFromJson(json);
}
