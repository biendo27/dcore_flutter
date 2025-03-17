part of '../blocs.dart';

@freezed
class StoreHomeState with _$StoreHomeState {
  const factory StoreHomeState({
    @Default(false) bool isLoading,
    @Default(StoreHome()) StoreHome storeHome,
  }) = _StoreHomeState;

  factory StoreHomeState.initial() => const StoreHomeState();
}
