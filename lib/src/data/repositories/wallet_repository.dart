part of 'repositories.dart';

@LazySingleton(as: IWalletRepository)
class WalletRepository with DataStateConvertible implements IWalletRepository {
  final WalletApi _walletApi;
  WalletRepository(this._walletApi);

  @override
  Future<BaseResponse<Wallet>> fetchWallet(int page) {
    return request(apiCall: () => _walletApi.fetchWallet(page));
  }

  @override
  Future<BaseResponse<Transaction>> requestWithdraw(
    int coin,
    String bankName,
    String bankNumber,
    String bankOwner,
    String note,
  ) {
    return request(apiCall: () => _walletApi.requestWithdraw(coin, bankName, bankNumber, bankOwner, note));
  }

  @override
  Future<BaseResponse<Transaction>> fetchWalletDetail(int transactionId) {
    return request(apiCall: () => _walletApi.fetchWalletDetail(transactionId));
  }

  @override
  Future<BaseResponse<int>> requestChangeCoinToMoney(int coin) {
    return request(apiCall: () => _walletApi.requestChangeCoinToMoney(coin));
  }

  @override
  Future<BaseResponse<Transaction>> walletUploadDeposit(String image, int transactionId) {
    return request(apiCall: () => _walletApi.walletUploadDeposit(image, transactionId.toString()));
  }

  @override
  Future<BaseResponse<String>> walletPolicy() {
    return request(apiCall: () => _walletApi.walletPolicy());
  }

  @override
  Future<BaseResponseList<PaymentMethod>> walletPaymentMethod() {
    return requestList(apiCall: () => _walletApi.walletPaymentMethod());
  }

  @override
  Future<BaseResponse<PackageResponse>> walletPackage() {
    return request(apiCall: () => _walletApi.walletPackage());
  }

  @override
  Future<BaseResponse<Transaction>> walletDeposit(int packageId, int paymentMethodId) {
    return request(apiCall: () => _walletApi.walletDeposit(packageId, paymentMethodId));
  }

  @override
  Future<BaseResponse<Banking>> walletBanking(int transactionId) {
    return request(apiCall: () => _walletApi.walletBanking(transactionId));
  }

  @override
  Future<BaseResponse<Transaction>> walletInAppPurchase(Map<String, dynamic> body) {
    return request(apiCall: () => _walletApi.walletInAppPurchase(body));
  }

  @override
  Future<BaseResponse<String>> walletCreatePaymentVNPayTransaction(int transactionId) {
    return request(apiCall: () => _walletApi.walletCreatePaymentVNPayTransaction(transactionId));
  }

  @override
  Future<BaseResponse<String>> walletCreatePaymentVNPayOrder(int orderGroupId) {
    return request(apiCall: () => _walletApi.walletCreatePaymentVNPayOrder(orderGroupId));
  }
}
