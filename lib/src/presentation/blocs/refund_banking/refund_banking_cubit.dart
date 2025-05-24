part of '../blocs.dart';

@lazySingleton
class RefundBankingCubit extends Cubit<RefundBankingState> with CubitActionMixin<RefundBankingState> {
  final IRefundBankingRepository _refundBankingRepository;
  RefundBankingCubit(this._refundBankingRepository) : super(RefundBankingState.initial());

  void reset() => emit(RefundBankingState.initial());
  void setSelectedBank(UserBank? bank) => emit(state.copyWith(selectedBank: bank));

  void fetchRefundBanking() async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: _refundBankingRepository.fetchRefundBanking,
      onSuccess: (response) {
        emit(state.copyWith(refundBanking: response.data!, selectedBank: response.data!.bank));
      },
    );
  }

  void fetchRefundBankingListBankData() async {
    executeListAction(
      action: _refundBankingRepository.fetchRefundBankingListBankData,
      onSuccess: (response) => emit(state.copyWith(listBankData: response.data)),
    );
  }

  void updateRefundBanking(RefundBanking refundBanking) async {
    Map<String, dynamic> data = {
      'bank_id': state.selectedBank?.id ?? 0,
      'bank_owner': refundBanking.bankOwner,
      'bank_number': refundBanking.bankNumber,
      'phone': refundBanking.phone,
    };

    executeEmptyAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _refundBankingRepository.updateRefundBanking(data),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        DNavigator.back();
      },
    );
  }
}
