part of '../blocs.dart';

@freezed
abstract class LiveRequestState with _$LiveRequestState {
  const factory LiveRequestState({
    @Default(false) bool isLoading,
    @Default(BasePageBreak<LiveRequest>()) BasePageBreak<LiveRequest> liveRequests,
    @Default(LiveRequest()) LiveRequest currentLiveRequest,
    @Default([]) List<LivePlatform> livePlatforms,
    @Default([]) List<LiveArea> liveAreas,
    LivePlatform? selectedLivePlatform,
    LiveArea? selectedLiveArea,
  }) = _LiveRequestState;

  factory LiveRequestState.initial() => LiveRequestState();
}
