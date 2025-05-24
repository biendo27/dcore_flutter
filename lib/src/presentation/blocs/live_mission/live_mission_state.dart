part of '../blocs.dart';

@freezed
abstract class LiveMissionState with _$LiveMissionState {
  const factory LiveMissionState({
    @Default(false) bool isLoading,
    @Default(Live()) Live currentLive,
    @Default(BasePageBreak<LiveMission>()) BasePageBreak<LiveMission> missions,
    @Default(AppUser()) AppUser giftRecipient,
  }) = _LiveMissionState;

  factory LiveMissionState.initial() => LiveMissionState();
}
