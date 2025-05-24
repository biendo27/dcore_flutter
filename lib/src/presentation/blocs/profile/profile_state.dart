part of '../blocs.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default('') String avatar,
  }) = _ProfileState;

  factory ProfileState.initial() => const ProfileState();
}
