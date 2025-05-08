part of '../blocs.dart';

@freezed
abstract class RefundBankingState with _$RefundBankingState {
  const factory RefundBankingState({
    @Default(false) bool isLoading,
    @Default(RefundBanking()) RefundBanking refundBanking,
    @Default([]) List<UserBank> listBankData,
    UserBank? selectedBank,
  }) = _RefundBankingState;

  factory RefundBankingState.initial() => const RefundBankingState();
}
