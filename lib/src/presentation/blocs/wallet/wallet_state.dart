part of '../blocs.dart';

@freezed
abstract class WalletState with _$WalletState {
  const factory WalletState({
    @Default(false) bool isLoading,
    @Default(false) bool firstDeposit,
    @Default(0) int walletCoin,
    @Default([]) List<Transaction> listTransaction,
    @Default(Transaction()) Transaction transaction,
    @Default([]) List<Package> packages,
    @Default(Banking()) Banking banks,
    @Default([]) List<PaymentMethod> paymentMethods,
    @Default('') String policy,
    @Default(0) int coinToMoney,
  }) = _WalletState;

  factory WalletState.initial() => const WalletState();

  factory WalletState.fromJson(Map<String, dynamic> json) => _$WalletStateFromJson(json);
}

extension WalletStateExtension on WalletState {
  List<PaymentMethod> get appPaymentMethods {
    List<PaymentMethod> paymentMethodTmps = [...paymentMethods];
    if (Platform.isAndroid) {
      paymentMethodTmps.removeWhere((element) => element.id == 4);
    }

    if (Platform.isIOS) {
      paymentMethodTmps.removeWhere((element) => element.id == 5);
    }

    return paymentMethodTmps;
  }
}
