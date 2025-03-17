part of '../blocs.dart';

@lazySingleton
class LiveRequestCubit extends Cubit<LiveRequestState> with CubitActionMixin<LiveRequestState> {
  final ILiveRepository _liveRepository;

  LiveRequestCubit(this._liveRepository) : super(LiveRequestState.initial());

  void setCurrentLiveRequest(LiveRequest liveRequest) => emit(state.copyWith(currentLiveRequest: liveRequest));
  void setLivePlatform(LivePlatform? livePlatform) => emit(state.copyWith(selectedLivePlatform: livePlatform));
  void setLiveArea(LiveArea? liveArea) => emit(state.copyWith(selectedLiveArea: liveArea));

  Future<void> getLiveRequestList({bool isInit = false}) async {
    if (state.liveRequests.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.liveRequests.nextPage;

    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _liveRepository.getLiveRequest(page),
      currentPageData: state.liveRequests,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(liveRequests: mergedPageBreakData),
    );
  }

  Future<void> getLiveRequestDetail(int id) async {
    executeAction(
      action: () => _liveRepository.getLiveRequestDetail(id),
      onSuccess: (response) {
        emit(state.copyWith(currentLiveRequest: response.data!));
      },
    );
  }

  Future<void> createLiveRequest({
    required String startTime,
    required String endTime,
    required String fromDay,
    required String toDay,
  }) async {
    String startAt = '$fromDay $startTime'.toUTCDateTimeString;
    String endAt = '$toDay $endTime'.toUTCDateTimeString;
    executeEmptyAction(
      action: () => _liveRepository.createLiveRequest({
        'start_at': startAt,
        'end_at': endAt,
        'live_platform_id': state.selectedLivePlatform?.id,
        'area_id': state.selectedLiveArea?.id,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        emit(state.copyWith(currentLiveRequest: response.data!));
        getLiveRequestList(isInit: true);
        DNavigator.replaceNamed(RouteNamed.liveBreakList);
      },
    );
  }

  Future<void> deleteLiveRequest(int liveRequestId) async {
    executeEmptyAction(
      action: () => _liveRepository.deleteLiveRequest({
        'live_request_id': liveRequestId,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        BasePageBreak<LiveRequest> liveRequestList = state.liveRequests;
        List<LiveRequest> liveRequestData = [...liveRequestList.data];
        liveRequestData.removeWhere((element) => element.id == liveRequestId);
        liveRequestList = liveRequestList.copyWith(data: liveRequestData);
        emit(state.copyWith(liveRequests: liveRequestList, currentLiveRequest: LiveRequest()));
      },
    );
  }

  void getLivePlatforms() {
    executeListAction(
      action: () => _liveRepository.getLivePlatforms(),
      onSuccess: (response) => emit(state.copyWith(livePlatforms: response.data)),
    );
  }

  void getLiveAreas() {
    executeListAction(
      action: () => _liveRepository.getLiveAreas(),
      onSuccess: (response) => emit(state.copyWith(liveAreas: response.data)),
    );
  }
}
