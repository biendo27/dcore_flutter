part of '../blocs.dart';

@freezed
abstract class ModerationState with _$ModerationState {
  const factory ModerationState({
    @Default(false) bool isLoading,
    @Default(false) bool isVideoSafe,
    String? errorMessage,
    ModerationResponse? lastResponse,
  }) = _ModerationState;

  factory ModerationState.initial() => const ModerationState();
}
