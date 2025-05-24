part of '../blocs.dart';

@lazySingleton
class LiveMissionCubit extends Cubit<LiveMissionState> with CubitActionMixin<LiveMissionState> {
  final ILiveRepository _liveRepository;
  LiveMissionCubit(this._liveRepository) : super(LiveMissionState.initial());

  void setCurrentLive(Live live) => emit(state.copyWith(currentLive: live));
  void setGiftRecipient(AppUser user) => emit(state.copyWith(giftRecipient: user));

  void getLiveMission({bool isInit = false}) async {
    if (state.missions.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.missions.nextPage;
    int requestLiveId = state.currentLive.id;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _liveRepository.getLiveMission(requestLiveId, page),
      currentPageData: state.missions,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(missions: mergedPageBreakData),
    );
  }

  void receiveMission(int missionId) async {
    executeEmptyAction(
      action: () => _liveRepository.receiveLiveMission(missionId),
      onSuccess: (data) => DMessage.showMessage(message: data.message, type: MessageType.success),
    );
  }

  void goWhellWebView() async {
    String url = '${"https://minigame.venusshop.top"}${AppEndpoint.liveWhell}?live_id=${state.currentLive.id}&access_token=${AppGlobalValue.accessToken}';

    debugPrint(url);
    DNavigator.goNamed(RouteNamed.liveWhellWebview, extra: url);
  }

  void getLiveRandom() async {
    if (state.currentLive.id == 0) return;
    if (!state.currentLive.isUserCanGetGift) {
      DMessage.showMessage(message: AppConfig.context?.text.notEligibleForGift ?? '', type: MessageType.info);
      return;
    }
    executeAction(
      action: () => _liveRepository.getLiveRandom(state.currentLive.id),
      onSuccess: (response) => setGiftRecipient(response.data ?? AppUser()),
    );
  }
}
