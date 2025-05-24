part of 'repositories.dart';

abstract interface class IWalletRepository {
  Future<BaseResponse<Wallet>> fetchWallet(int page);
  Future<BaseResponse<Transaction>> requestWithdraw(int coin, String bankName, String bankNumber, String bankOwner, String note);
  Future<BaseResponse<Transaction>> fetchWalletDetail(int transactionId);
  Future<BaseResponse<Transaction>> walletDeposit(int packageId, int paymentMethodId);
  Future<BaseResponse<Transaction>> walletUploadDeposit(String image, int transactionId);
  Future<BaseResponse<int>> requestChangeCoinToMoney(int coin);
  Future<BaseResponse<String>> walletPolicy();
  Future<BaseResponseList<PaymentMethod>> walletPaymentMethod();
  Future<BaseResponse<PackageResponse>> walletPackage();
  Future<BaseResponse<Banking>> walletBanking(int transactionId);
  Future<BaseResponse<Transaction>> walletInAppPurchase(Map<String, dynamic> body);
  Future<BaseResponse<String>> walletCreatePaymentVNPayTransaction(int transactionId);
  Future<BaseResponse<String>> walletCreatePaymentVNPayOrder(int orderGroupId);
}
