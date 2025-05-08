part of '../models.dart';

@freezed
abstract class Filter with _$Filter {
  const factory Filter({
    @Default([]) List<RatingFilter> rating,
    @Default([]) List<StoreCategory> category,
    @Default([]) List<PriceRangeFilter> priceRange,
    @Default([]) List<ServicePromotionFilter> servicePromotion,
  }) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}

enum SortOption {
  @JsonValue('related')
  related,
  @JsonValue('newest')
  newest,
  @JsonValue('best_selling')
  bestSelling,
  @JsonValue('price')
  price;

  int get name {
    return switch (this) {
      SortOption.related => 0,
      SortOption.newest => 1,
      SortOption.bestSelling => 2,
      SortOption.price => 3,
    };
  }

  String displayValue(BuildContext context) {
    return switch (this) {
      SortOption.related => context.text.related,
      SortOption.newest => context.text.newest,
      SortOption.bestSelling => context.text.bestSeller,
      SortOption.price => context.text.price,
    };
  }
}

enum SortType {
  @JsonValue('asc')
  asc,
  @JsonValue('desc')
  desc;
}
