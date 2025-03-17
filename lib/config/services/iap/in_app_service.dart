part of '../services.dart';

enum PurchaseType { consumable, nonConsumable, subscription }

class InAppService {
  static final InAppService _instance = InAppService._();
  static InAppService get instance => _instance;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = [];
  final List<PurchaseDetails> _purchases = [];
  bool _available = true;

  // Callbacks for purchase events
  void Function(String message)? onPurchaseError;
  void Function(String message)? onPurchasePending;
  void Function(String message, PurchaseDetails purchase)? onPurchaseSuccess;
  void Function(List<ProductDetails>)? onProductsLoaded;
  void Function(PurchaseDetails purchase)? onPurchaseDelivered;

  InAppService._();

  bool get isAvailable => _available;
  List<ProductDetails> get products => _products;
  List<PurchaseDetails> get purchases => _purchases;

  Future<void> init({
    required Set<String> productIds,
    void Function(String)? onError,
    void Function(String)? onPending,
    void Function(String, PurchaseDetails)? onSuccess,
    void Function(List<ProductDetails>)? onProducts,
    void Function(PurchaseDetails)? onDelivered,
  }) async {
    onPurchaseError = onError;
    onPurchasePending = onPending;
    onPurchaseSuccess = onSuccess;
    onProductsLoaded = onProducts;
    onPurchaseDelivered = onDelivered;

    try {
      _available = await _inAppPurchase.isAvailable();
      if (!_available) return;
      
      await _getProducts(productIds: productIds);
      _setupPurchaseStream();
    } catch (e) {
      _available = false;
      onPurchaseError?.call('Failed to initialize in-app purchases: $e');
    }
  }

  Future<void> _getProducts({required Set<String> productIds}) async {
    try {
      final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(productIds);
      _products = response.productDetails;
      onProductsLoaded?.call(_products);
    } catch (e) {
      onPurchaseError?.call('Failed to load products: $e');
    }
  }

  Future<void> purchaseProduct(ProductDetails product, PurchaseType type) async {
    try {
      final purchaseParam = PurchaseParam(productDetails: product);

      switch (type) {
        case PurchaseType.consumable:
          await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
          break;
        case PurchaseType.nonConsumable:
          await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          break;
        case PurchaseType.subscription:
          await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          break;
      }
    } catch (e) {
      onPurchaseError?.call('Failed to initiate purchase: $e');
    }
  }

  Future<void> restorePurchases() async {
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      onPurchaseError?.call('Failed to restore purchases: $e');
    }
  }

  void _setupPurchaseStream() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _purchases.addAll(purchaseDetailsList);
        _handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () => _subscription?.cancel(),
      onError: (error) {
        _subscription?.cancel();
        onPurchaseError?.call('Purchase stream error: $error');
      },
    );
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          onPurchasePending?.call('Payment is pending');
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            await _deliverProduct(purchaseDetails);
            onPurchaseSuccess?.call('Payment successful', purchaseDetails);
            onPurchaseDelivered?.call(purchaseDetails);
          } else {
            onPurchaseError?.call('Purchase verification failed');
          }
          break;
        case PurchaseStatus.error:
          onPurchaseError?.call('Payment failed: ${purchaseDetails.error}');
          break;
        default:
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // Implement your purchase verification logic here
    return true;
  }

  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    // Implement your product delivery logic here
  }

  ProductDetails? findProductById(String productId) {
    try {
      return _products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  List<ProductDetails> findProductsByIds(List<String> productIds) {
    return _products.where((product) => productIds.contains(product.id)).toList();
  }

  List<PurchaseDetails> getPurchaseHistory(String productId) {
    return _purchases.where((purchase) => purchase.productID == productId).toList();
  }

  bool isProductPurchased(String productId) {
    return _purchases.any((purchase) => purchase.productID == productId && purchase.status == PurchaseStatus.purchased);
  }

  void dispose() {
    _subscription?.cancel();
  }
}