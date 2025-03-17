part of '../blocs.dart';

@freezed
class ReceiptState with _$ReceiptState {
  const factory ReceiptState({
    @Default(false) bool isLoading,
  }) = _ReceiptState;

  factory ReceiptState.initial() => const ReceiptState();
}
