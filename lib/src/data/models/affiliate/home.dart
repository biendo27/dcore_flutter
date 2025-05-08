part of '../models.dart';

@freezed
abstract class HomeAffiliateRepository with _$HomeAffiliateRepository {
  const factory HomeAffiliateRepository({
    @Default(0) int totalOrderSuccess,
    @Default(0) int totalOrder,
    @Default(0) int totalCommission,
    @Default(ProductListHome()) ProductListHome products,
  }) = _HomeAffiliateRepository;

  factory HomeAffiliateRepository.fromJson(Map<String, dynamic> json) => _$HomeAffiliateRepositoryFromJson(json);
}

@freezed
abstract class ProductListHome with _$ProductListHome {
  const factory ProductListHome({
    @Default(0) int currentPage,
    @Default([]) List<ProductData> data,
  }) = _ProductListHome;

  factory ProductListHome.fromJson(Map<String, dynamic> json) => _$ProductListHomeFromJson(json);
}

@freezed
abstract class ProductData with _$ProductData {
  const factory ProductData({
    @Default(AppUser()) AppUser user,
    @Default(ProductAffiliate()) ProductAffiliate product,
    @Default("") String link,
  }) = _ProductData;

  factory ProductData.fromJson(Map<String, dynamic> json) => _$ProductDataFromJson(json);
}
