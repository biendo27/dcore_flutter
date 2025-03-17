part of '../blocs.dart';

@lazySingleton
class ProductCubit extends Cubit<ProductState> with CubitActionMixin<ProductState> {
  final ISellProductRepository _sellProductRepository;
  final ISellVoucherRepository _sellVoucherRepository;
  ProductCubit(this._sellProductRepository, this._sellVoucherRepository) : super(ProductState.initial());

  void setCurrentProduct(Product product) {
    emit(state.copyWith(currentProduct: product));
  }

  void initProductData(Product product) {
    setCurrentProduct(product);
    getProductDetail();
    getProductVoucher();
  }

  Future<void> getProductDetail({int productId = 0}) async {
    int requestProductId = productId == 0 ? state.currentProduct.id : productId;
    if (requestProductId == 0) return;
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellProductRepository.fetchProductDetail(requestProductId),
      onSuccess: (response) {
        emit(state.copyWith(currentProductDetail: response.data!));
      },
    );
  }

  void getProductVoucher() {
    if (state.currentProduct.id == 0) return;

    executeListAction(
      action: () => _sellProductRepository.fetchProductVoucher(state.currentProduct.id),
      onSuccess: (response) => emit(state.copyWith(vouchers: response.data)),
    );
  }

  Future<void> bookmarkProduct() async {
    executeEmptyAction(
      action: () => _sellProductRepository.bookmarkProduct(state.currentProduct.id),
      onSuccess: (response) {
        ProductDetail productDetail = state.currentProductDetail;
        Product product = productDetail.product;
        product = product.copyWith(bookmarked: !product.bookmarked);
        productDetail = productDetail.copyWith(product: product);
        emit(state.copyWith(currentProduct: product, currentProductDetail: productDetail));
      },
    );
  }

  Future<void> saveVoucher(int voucherId) async {
    executeEmptyAction(
      action: () => _sellVoucherRepository.saveVoucher(voucherId),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        AppConfig.context?.read<LiveCubit>().getLiveBooth();
        getProductVoucher();
      },
    );
  }

  Future<void> fetchProductService() async {
    executeAction(
      action: _sellProductRepository.fetchProductService,
      onSuccess: (response) => emit(state.copyWith(productService: response.data!)),
    );
  }

  Future<void> fetchProductCancelOrderTutorialTerm() async {
    executeAction(
      action: _sellProductRepository.fetchProductCancelOrderTutorialTerm,
      onSuccess: (response) => emit(state.copyWith(productCancelOrderTutorialTerm: response.data!)),
    );
  }
}
