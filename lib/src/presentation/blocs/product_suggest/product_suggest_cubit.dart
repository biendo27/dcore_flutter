part of '../blocs.dart';

@lazySingleton
class ProductSuggestCubit extends Cubit<ProductSuggestState> with CubitActionMixin<ProductSuggestState> {
  final ISellProductRepository _sellProductRepository;
  ProductSuggestCubit(this._sellProductRepository) : super(ProductSuggestState.initial());

  void fetchProductSuggest() async {
    executeListAction(
      action: _sellProductRepository.fetchProductSuggest,
      onSuccess: (response) {
        emit(state.copyWith(products: response.data));
        AppConfig.context?.read<ProductCubit>().getProductDetail(productId: response.data.first.id);
      },
    );
  }
}
