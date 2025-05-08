part of '../models.dart';

@freezed
abstract class StoreCategory with _$StoreCategory {
  const factory StoreCategory({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String image,
    @Default(null) DateTime? createdAt,
    @Default('') String createdAtFormat,
  }) = _StoreCategory;

  factory StoreCategory.fromJson(Map<String, dynamic> json) => _$StoreCategoryFromJson(json);
}
