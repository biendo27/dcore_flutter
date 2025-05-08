part of '../blocs.dart';

@freezed
abstract class LiveSettingState with _$LiveSettingState {
  const factory LiveSettingState({
    @Default(false) bool isLoading,
    @Default(LiveRole.host) LiveRole liveRole,
    @Default(LiveSettingStatus.preLive) LiveSettingStatus liveStatus,
    @Default(0) int audienceId,
    @Default(false) bool enableMic,
  }) = _LiveSettingState;

  factory LiveSettingState.initial() => const LiveSettingState();
}

enum LiveRole {
  host,
  audience,
}

enum LiveSettingStatus {
  setupLiveInfo,
  preLive,
  live,
  end,
}
