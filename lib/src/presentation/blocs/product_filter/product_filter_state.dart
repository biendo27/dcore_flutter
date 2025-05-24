part of '../blocs.dart';

@freezed
abstract class ProductFilterState with _$ProductFilterState {
  const factory ProductFilterState({
    @Default(false) bool isLoading,
    @Default(SortType.asc) SortType sortType,
    @Default('') String keyword,
    @Default(Filter()) Filter filter,
    @Default(RatingFilter()) RatingFilter selectedRating,
    @Default(StoreCategory()) StoreCategory selectedCategory,
    @Default(PriceRangeFilter()) PriceRangeFilter selectedPriceRange,
    @Default(ServicePromotionFilter()) ServicePromotionFilter selectedServicePromotion,
    @Default([]) List<Product> products,
  }) = _ProductFilterState;

  factory ProductFilterState.initial() => const ProductFilterState();
}

extension ProductFilterStateX on ProductFilterState {
  bool get isSortByRating => selectedRating.value > 0;
  bool get isSortByCategory => selectedCategory.id > 0;

  String ratingSortLabel(BuildContext context) {
    if (!isSortByRating) return context.text.evaluate;
    return selectedRating.name;
  }

  String categorySortLabel(BuildContext context) {
    if (!isSortByCategory) return context.text.byCategory;
    return selectedCategory.name;
  }
}
