part of '../blocs.dart';

@lazySingleton
class OrderReviewCubit extends Cubit<OrderReviewState> with CubitActionMixin<OrderReviewState> {
  final ISellOrderRepository _sellOrderRepository;
  OrderReviewCubit(this._sellOrderRepository) : super(OrderReviewState.initial());

  Future<void> fetchUserReview({bool isInit = false}) async {
    if (state.userReviews.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.userReviews.nextPage;
    executePageBreakAction(
      isInit: isInit,
      action: () => _sellOrderRepository.fetchUserReview(page),
      currentPageData: state.userReviews,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(userReviews: mergedPageBreakData),
    );
  }

  Future<void> fetchProductPendingReview({bool isInit = false}) async {
    if (state.productPendingReviews.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.productPendingReviews.nextPage;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.fetchUserReviewPending(page),
      currentPageData: state.productPendingReviews,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(productPendingReviews: mergedPageBreakData),
    );
  }
}
