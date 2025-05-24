part of '../blocs.dart';

@lazySingleton
class ProductFilterCubit extends Cubit<ProductFilterState> with CubitActionMixin<ProductFilterState> {
  final ISellProductRepository _sellProductRepository;
  ProductFilterCubit(this._sellProductRepository) : super(ProductFilterState.initial());

  void resetSelectedFilter() => emit(state.copyWith(
        selectedRating: RatingFilter(),
        selectedCategory: StoreCategory(),
        selectedPriceRange: PriceRangeFilter(),
        selectedServicePromotion: ServicePromotionFilter(),
        keyword: '',
      ));
  void changeSortType(SortType sortType) => emit(state.copyWith(sortType: sortType));
  void changeKeyword(String keyword) => emit(state.copyWith(keyword: keyword));
  void changeFilter(Filter filter) => emit(state.copyWith(filter: filter));
  void changeSelectedRating(RatingFilter selectedRating) => emit(state.copyWith(selectedRating: selectedRating));
  void changeSelectedCategory(StoreCategory selectedCategory) => emit(state.copyWith(selectedCategory: selectedCategory));
  void changeSelectedPriceRange(PriceRangeFilter selectedPriceRange) => emit(state.copyWith(selectedPriceRange: selectedPriceRange));
  void changeSelectedServicePromotion(ServicePromotionFilter selectedServicePromotion) => emit(state.copyWith(selectedServicePromotion: selectedServicePromotion));

  void fetchProductFilter() async {
    executeAction(
      action: _sellProductRepository.fetchProductFilter,
      onSuccess: (response) => changeFilter(response.data!),
    );
  }

  void searchProductNoFilter() async {
    executeListAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellProductRepository.fetchProduct({}),
      onSuccess: (response) => emit(state.copyWith(products: response.data)),
    );
  }

  void searchProduct({
    int fromPrice = 0,
    int toPrice = 0,
    SortOption sortOption = SortOption.related,
  }) async {
    int fromPriceParam = fromPrice > 0 ? fromPrice : state.selectedPriceRange.from;
    int toPriceParam = toPrice > 0 ? toPrice : state.selectedPriceRange.to;

    Map<String, dynamic> params = {
      if (state.selectedRating.value > 0) 'rating': state.selectedRating.value,
      if (state.selectedCategory.id > 0) 'category_id': state.selectedCategory.id,
      if (fromPriceParam > 0) 'from_price': fromPriceParam,
      if (toPriceParam > 0) 'to_price': toPriceParam,
      if (state.selectedServicePromotion.key > 0) 'service_promotion': state.selectedServicePromotion.key,
      'type': sortOption.index,
      'sort': state.sortType.name,
      if (state.keyword.isNotEmpty) 'keyword': state.keyword,
    };

    executeListAction(
      action: () => _sellProductRepository.fetchProduct(params),
      onSuccess: (response) {
        emit(state.copyWith(products: response.data));
      },
    );
  }
}
