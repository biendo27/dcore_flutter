part of '../models.dart';

@freezed
abstract class ProductList with _$ProductList {
  const factory ProductList({
    @Default(0) int currentPage,
    @Default([]) List<ProductAffiliate> data,
  }) = _ProductList;

  factory ProductList.fromJson(Map<String, dynamic> json) => _$ProductListFromJson(json);
}

@freezed
abstract class ProductAffiliate with _$ProductAffiliate {
  const factory ProductAffiliate({
    @Default(0) int id,
    @Default('') String thumbnail,
    @Default([]) List<String> images,
    @Default(0) int discount,
    @Default("") String name,
    // @Default('') int affiliate_type,
    @Default(0) int originPrice,
    @Default('') String affiliateValue,
    @Default(0) int sold,
    @Default(0) int price,
    @Default(0) int stock,
    @Default(0) int totalRatings,
    @Default(0) int averageRating,
    @Default(0) int discountedPrice,
    @Default("") String deliveryTime,
    @Default("") String description,
    @Default(false) bool bookmarked,
    @Default([]) List<Attribute> attributes,
    @Default(false) bool isPinned,
    @Default("") String sku,
    @Default("") String createdAtFormat,
    @Default("") String commissionValue,
    @Default("") String link,
    @Default(0) int affiliateOrderCondition,
    @Default(0) int affiliateStock,
    @Default(Store()) Store store,
    @Default(ProductCategoryAffiliate()) ProductCategoryAffiliate category,
    @Default(ProductBrandAffiliate()) ProductBrandAffiliate brand,
  }) = _ProductAffiliate;

  factory ProductAffiliate.fromJson(Map<String, dynamic> json) => _$ProductAffiliateFromJson(json);
}

@freezed
abstract class ProductCategoryAffiliate with _$ProductCategoryAffiliate {
  const factory ProductCategoryAffiliate({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String image,
    @Default('') String createdAtFormat,
  }) = _ProductCategoryAffiliate;

  factory ProductCategoryAffiliate.fromJson(Map<String, dynamic> json) => _$ProductCategoryAffiliateFromJson(json);
}

@freezed
abstract class ProductBrandAffiliate with _$ProductBrandAffiliate {
  const factory ProductBrandAffiliate({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String image,
    @Default('') String description,
    @Default('') String createdAtFormat,
  }) = _ProductBrandAffiliate;

  factory ProductBrandAffiliate.fromJson(Map<String, dynamic> json) => _$ProductBrandAffiliateFromJson(json);
}
