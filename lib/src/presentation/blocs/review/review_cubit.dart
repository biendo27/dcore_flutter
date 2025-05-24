part of '../blocs.dart';

@lazySingleton
class ReviewCubit extends Cubit<ReviewState> with CubitActionMixin<ReviewState> {
  final ISellProductRepository _sellProductRepository;
  ReviewCubit(this._sellProductRepository) : super(ReviewState.initial());

  void setProduct(Product product) => emit(state.copyWith(product: product));

  Future<void> getProductReview({bool isInit = false}) async {
    if (state.reviews.isLastPage && !isInit) return;
    int productId = state.product.id;
    int page = isInit ? 1 : state.reviews.nextPage;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellProductRepository.fetchProductReview(productId, page),
      currentPageData: state.reviews,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(reviews: mergedPageBreakData),
    );
  }
}
