part of '../blocs.dart';

@freezed
abstract class LiveGiftState with _$LiveGiftState {
  const factory LiveGiftState({
    @Default(false) bool isLoading,
    @Default([]) List<Gift> gifts,
  }) = _LiveGiftState;

  factory LiveGiftState.initial() => const LiveGiftState();
}
