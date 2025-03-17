part of '../blocs.dart';

@lazySingleton
class WalletCubit extends Cubit<WalletState> with CubitActionMixin<WalletState> {
  final IWalletRepository _walletRepository;
  final IUploadRepository _uploadRepository;
  WalletCubit(this._walletRepository, this._uploadRepository) : super(WalletState.initial());

  List<Transaction> _transactions = [];

  Future<void> fetchWallet(int page) async {
    executeAction(
      action: () => _walletRepository.fetchWallet(page),
      onSuccess: (response) {
        if (response.code == 200) {
          if (page == 1) {
            _transactions = response.data!.transactions.data;
          } else {
            _transactions = [..._transactions, ...response.data!.transactions.data];
          }
          emit(state.copyWith(walletCoin: response.data!.wallet, listTransaction: _transactions));
        }
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> fetchWalletDetail(int transactionId) async {
    executeAction(
      action: () => _walletRepository.fetchWalletDetail(transactionId),
      onSuccess: (response) => emit(state.copyWith(transaction: response.data!)),
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
      setLoadingState: (state, {required bool isLoading}) => state.copyWith(isLoading: isLoading),
    );
  }

  Future<void> requestWithdraw(
    String coin,
    String bankName,
    String bankNumber,
    String bankOwner,
    String note,
  ) async {
    executeAction(
      action: () => _walletRepository.requestWithdraw(int.parse(coin), bankName, bankNumber, bankOwner, note),
      onSuccess: (res) {
        if (res.code == 200) {
          DNavigator.goNamed(RouteNamed.requestSuccess, extra: res.data!.id);
        }
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> requestChangeCoinToMoney(int coin) async {
    executeAction(
        action: () => _walletRepository.requestChangeCoinToMoney(coin),
        onSuccess: (response) => emit(state.copyWith(coinToMoney: response.data!)),
        onFailure: (mess) => emit(state.copyWith(coinToMoney: 0)));
  }

  Future<void> walletBanking(int transactionId) async {
    executeAction(
      action: () => _walletRepository.walletBanking(transactionId),
      onSuccess: (response) => emit(state.copyWith(banks: response.data!)),
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> walletDeposit(int packageId, int paymentMethodId, {void Function(int)? callback}) async {
    executeAction(
      action: () => _walletRepository.walletDeposit(packageId, paymentMethodId),
      onSuccess: (res) {
        if (res.code == 200) {
          final id = res.data!.id;
          callback?.call(id);
        }
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> walletPackage({void Function(Set<String>)? onSuccess}) async {
    executeAction(
      action: () => _walletRepository.walletPackage(),
      onSuccess: (response) {
        emit(state.copyWith(packages: response.data!.packages, firstDeposit: response.data!.firstDeposit));
        onSuccess?.call(response.data!.packages.map((e) => e.inAppId).toSet());
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> walletPaymentMethod() async {
    executeListAction(
      action: () => _walletRepository.walletPaymentMethod(),
      onSuccess: (response) => emit(state.copyWith(paymentMethods: response.data)),
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> walletPolicy() async {
    executeAction(
      action: () => _walletRepository.walletPolicy(),
      onSuccess: (response) => emit(state.copyWith(policy: response.data ?? '')),
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> walletUploadDeposit(File image, int transactionId) async {
    final BaseResponseList<AppFile> responseImg = await _uploadRepository.uploadFile(
      UploadType.postImage,
      [File(image.path)],
    );

    executeAction(
      action: () => _walletRepository.walletUploadDeposit(responseImg.data.first.url, transactionId),
      onSuccess: (res) {
        if (res.code == 200) {
          DNavigator.goNamed(RouteNamed.requestSuccess, extra: transactionId);
        }
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> walletInAppPurchase(String packageId) async {
    int paymentMethodId = Platform.isAndroid ? 5 : 4;
    executeAction(
      action: () => _walletRepository.walletInAppPurchase({
        'in_app_id': packageId,
        'payment_method_id': paymentMethodId,
      }),
      onSuccess: (res) {
        DMessage.showMessage(message: res.message, type: MessageType.success);
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> walletCreatePaymentVNPayTransaction(int transactionId, {void Function(String)? callback}) async {
    executeAction(
      action: () => _walletRepository.walletCreatePaymentVNPayTransaction(transactionId),
      onSuccess: (res) => callback?.call(res.data!),
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> walletCreatePaymentVNPayOrder(int orderId, {void Function(String)? onSuccess}) async {
    executeAction(
      action: () => _walletRepository.walletCreatePaymentVNPayOrder(orderId),
      onSuccess: (res) => onSuccess?.call(res.data!),
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  void clearTransaction() {
    emit(state.copyWith(transaction: Transaction()));
  }
}
