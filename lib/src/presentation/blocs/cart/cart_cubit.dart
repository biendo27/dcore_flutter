part of '../blocs.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> with CubitActionMixin<CartState> {
  final ISellCartRepository _sellCartRepository;
  final ISellOrderRepository _sellOrderRepository;
  CartCubit(this._sellCartRepository, this._sellOrderRepository) : super(CartState.initial());

  void setProductCart(Product product) {
    emit(state.copyWith(productCart: product));
  }

  Future<void> fetchUserCart() async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellCartRepository.fetchCart(),
      onSuccess: (response) {
        emit(state.copyWith(userCart: response.data!));
      },
    );
  }

  void addToCart(Product product, int quantity, List<AttributeValue> attributeValues) {
    List<String> attributeValuesString = attributeValues.map((e) => e.value).toList();
    executeEmptyAction(
      action: () => _sellCartRepository.addCart({
        'product_id': product.id,
        'quantity': quantity,
        if (attributeValuesString.isNotEmpty) 'attribute_values': attributeValuesString,
        if (AppGlobalValue.affiliateId != 0) 'affiliate_id': AppGlobalValue.affiliateId,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        fetchUserCart();
        DNavigator.back();
      },
    );
  }

  void updateCartProduct({
    required Product product,
    int quantity = 0,
    List<AttributeValue> attributeValues = const [],
    void Function()? onSuccess,
  }) {
    int newQuantity = quantity;
    List<String> newAttributeValueIds = [];

    if (attributeValues.isNotEmpty) {
      newAttributeValueIds = attributeValues.map((e) => e.value).toList();
    }

    if (newQuantity <= 0) {
      newQuantity = product.quantity;
    }

    if (newAttributeValueIds.isEmpty) {
      newAttributeValueIds = product.variant.map((e) => e.value).toList();
    }

    executeEmptyAction(
      action: () => _sellCartRepository.updateCart({
        'cart_id': product.cartId,
        'quantity': newQuantity,
        if (newAttributeValueIds.isNotEmpty) 'attribute_values': newAttributeValueIds,
      }),
      onSuccess: (response) {
        fetchUserCart();
        onSuccess?.call();
      },
    );
  }

  void increaseCartProductQuantity({required Product product, void Function()? onSuccess}) {
    updateCartProduct(product: product, quantity: product.quantity + 1, onSuccess: onSuccess);
  }

  void decreaseCartProductQuantity({required Product product, void Function()? onSuccess}) {
    updateCartProduct(product: product, quantity: product.quantity - 1, onSuccess: onSuccess);
  }

  void deleteCartProduct(Product product) {
    executeEmptyAction(
      action: () => _sellCartRepository.deleteCart(product.cartId),
      onSuccess: (response) => fetchUserCart(),
    );
  }

  void getOrderVouchers({bool isInit = false, VoucherClassification classification = VoucherClassification.price}) {
    if (state.orderVouchers.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.orderVouchers.nextPage;
    int totalPrice = 1;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.orderVoucher(totalPrice, classification, page),
      currentPageData: state.orderVouchers,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(orderVouchers: mergedPageBreakData),
      onSuccess: (response) {
        emit(state.copyWith(orderVouchers: response.data!));
      },
    );
  }

  void getStoreVouchers({bool isInit = false}) {
    if (state.storeVouchers.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.storeVouchers.nextPage;
    int totalPrice = 1;
    int storeId = 1;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellOrderRepository.storeVoucher(storeId, totalPrice, page),
      currentPageData: state.storeVouchers,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(storeVouchers: mergedPageBreakData),
      onSuccess: (response) {
        emit(state.copyWith(storeVouchers: response.data!));
      },
    );
  }

  void getProductByVariant(List<AttributeValue> attributeValues) {
    if (attributeValues.isEmpty) return;
    executeEmptyAction(
      action: () => _sellCartRepository.fetchProductByVariant({
        'product_id': state.productCart.id,
        'attribute_values[]': attributeValues.map((e) => e.value).toList(),
      }),
      onSuccess: (response) {
        Product product = response.data!;
        product = product.copyWith(cartId: state.productCart.cartId);
        emit(state.copyWith(productCart: product));
      },
    );
  }
}
