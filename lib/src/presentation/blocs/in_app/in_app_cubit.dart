part of '../blocs.dart';

@lazySingleton
class InAppCubit extends Cubit<InAppState> {
  InAppCubit() : super(InAppState.initial());

  Future<void> init(Set<String> productIds) async {
    emit(state.copyWith(isLoading: true));

    await InAppService.instance.init(
      productIds: productIds,
      onError: (message) {
        emit(state.copyWith(error: message, isLoading: false));
        LogDev.warning('IN APP ERROR: $message');
        DMessage.showMessage(message: 'Giao dịch không thành công', type: MessageType.error);
      },
      onSuccess: (message, purchase) {
        AppConfig.context!.read<WalletCubit>().walletInAppPurchase(state.packageId);
        emit(state.copyWith(
          error: null,
          purchases: [...state.purchases, purchase],
          packageId: '',
        ));
        DNavigator.back();
        AppConfig.context!.read<UserCubit>().getUser();
        LogDev.warning('IN APP PURCHASE SUCCESS: $message ${purchase.toString()}');
      },
      onPending: (message) {
        emit(state.copyWith(error: message, isLoading: false));
        LogDev.warning('IN APP PURCHASE PENDING: $message');
        DMessage.showMessage(message: message, type: MessageType.info);
      },
      onProducts: (products) {
        emit(state.copyWith(
          products: products,
          isAvailable: true,
        ));
        LogDev.warning('IN APP PRODUCTS LOADED: ${products.toString()}');
      },
      onDelivered: (purchase) => _handleDeliveredPurchase(purchase),
    );

    emit(state.copyWith(
      isLoading: false,
      isAvailable: InAppService.instance.isAvailable,
    ));
  }

  Future<void> purchaseProduct(String productId, PurchaseType type) async {
    final product = InAppService.instance.findProductById(productId);
    if (product == null) {
      emit(state.copyWith(error: 'Product not found'));
      LogDev.warning('IN APP PURCHASE: Product not found');
      return;
    }

    emit(state.copyWith(isLoading: true));
    LogDev.warning('Start purchase: $productId - ${product.toString()} - $type');
    await InAppService.instance.purchaseProduct(product, type);
    emit(state.copyWith(packageId: productId));
  }

  Future<void> restorePurchases() async {
    emit(state.copyWith(isLoading: true));
    await InAppService.instance.restorePurchases();
    emit(state.copyWith(isLoading: false));
  }

  void _handleDeliveredPurchase(PurchaseDetails purchase) {
    final currentBalance = state.consumableBalance;

    if (purchase.status == PurchaseStatus.purchased) {
      currentBalance[purchase.productID] = (currentBalance[purchase.productID] ?? 0) + 1;
      emit(state.copyWith(consumableBalance: currentBalance));
    }
  }

  bool isProductOwned(String productId) => InAppService.instance.isProductPurchased(productId);

  List<PurchaseDetails> getPurchaseHistory(String productId) => InAppService.instance.getPurchaseHistory(productId);

  @override
  Future<void> close() {
    InAppService.instance.dispose();
    return super.close();
  }
}
