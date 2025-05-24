part of '../blocs.dart';

@lazySingleton
class LiveCubit extends Cubit<LiveState> with CubitActionMixin<LiveState> {
  final ILiveRepository _liveRepository;
  final ISellVoucherRepository _sellVoucherRepository;

  LiveCubit(this._liveRepository, this._sellVoucherRepository) : super(LiveState.initial());

  void setCurrentLive(Live live) {
    emit(state.copyWith(currentLive: live));
    AppConfig.context?.read<LiveMissionCubit>().setCurrentLive(live);
  }

  void setCurrentBreakRequest(BreakSchedule breakRequest) => emit(state.copyWith(currentBreakSchedule: breakRequest));
  void setLiveDuration(int duration) => emit(state.copyWith(currentLive: state.currentLive.copyWith(duration: duration)));
  void setLiveHeartCount(int heartCount) => emit(state.copyWith(currentLive: state.currentLive.copyWith(likesCount: heartCount)));
  void setLiveViewCount(int viewCount) => emit(state.copyWith(currentLive: state.currentLive.copyWith(viewCount: viewCount)));

  Future<void> getLiveList({bool isInit = false, String search = ''}) async {
    if (state.liveList.isLastPage && !isInit && search.isEmpty) return;
    bool initData = isInit || search.isNotEmpty;
    int page = initData ? 1 : state.liveList.nextPage;
    executePageBreakAction(
      isInit: initData,
      action: () => _liveRepository.getLiveList(page, search),
      currentPageData: state.liveList,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(liveList: mergedPageBreakData),
    );
  }

  Future<void> getLiveDetail({void Function(Live)? onSuccess}) async {
    if (state.currentLive.id == 0) return;
    int id = state.currentLive.id;
    executeAction(
      action: () => _liveRepository.getLiveDetail(id),
      onSuccess: (response) {
        emit(state.copyWith(currentLive: response.data!));
        onSuccess?.call(response.data!);
      },
    );
  }

  Future<void> createLive(Map<String, dynamic> body) async {
    executeAction(
      action: () => _liveRepository.createLive(body),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        emit(state.copyWith(currentLive: response.data!));
      },
    );
  }

  Future<void> cancelLive(String reason) async {
    executeEmptyAction(
      action: () => _liveRepository.cancelLive({
        'live_id': state.currentLive.id,
        'reason': reason,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        emit(state.copyWith(currentLive: Live()));
        getMyScheduleList(isInit: true);
        DNavigator.back();
      },
    );
  }

  Future<void> startLive({
    required String title,
    required String description,
    void Function()? onSuccess,
  }) async {
    if (state.currentLive.status == LiveStatus.live) return;
    Live currentLive = state.currentLive;
    currentLive = currentLive.copyWith(status: LiveStatus.live);
    emit(state.copyWith(currentLive: currentLive));
    executeAction(
      action: () => _liveRepository.startLive({
        'live_id': state.currentLive.id,
        'title': title,
        'description': description,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        emit(state.copyWith(currentLive: response.data!));
        onSuccess?.call();
      },
    );
  }

  Future<void> endLive(int duration) async {
    executeAction(
      action: () => _liveRepository.endLive(state.currentLive.id),
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      onSuccess: (response) {
        getMyScheduleList(isInit: true);
        getLiveList(isInit: true);
        DMessage.showMessage(message: response.message, type: MessageType.success);
        Live liveResponse = response.data!;
        liveResponse = liveResponse.copyWith(duration: duration);
        emit(state.copyWith(currentLive: liveResponse));
      },
    );
  }

  Future<void> requestLiveBreak({
    required String startTime,
    required String endTime,
    required String fromDay,
    required String toDay,
    required String reason,
  }) async {
    String startAt = '$fromDay $startTime'.toUTCDateTimeString;
    String endAt = '$toDay $endTime'.toUTCDateTimeString;
    executeAction(
      action: () => _liveRepository.createLeaveRequest({
        'start_at': startAt,
        'end_at': endAt,
        'reason': reason,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        emit(state.copyWith(currentBreakSchedule: response.data!));
        getBreakScheduleList(isInit: true);
        DNavigator.replaceNamed(RouteNamed.liveBreakList);
      },
    );
  }

  Future<void> getBreakScheduleList({bool isInit = false}) async {
    if (state.breakScheduleList.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.breakScheduleList.nextPage;

    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _liveRepository.getLeaveRequest(page),
      currentPageData: state.breakScheduleList,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(breakScheduleList: mergedPageBreakData),
    );
  }

  void fetchLiveOtherProduct({bool isInit = false}) async {
    if (state.liveOtherProducts.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.liveOtherProducts.nextPage;
    int liveId = state.currentLive.id;
    executePageBreakAction(
      isInit: isInit,
      action: () => _liveRepository.getLiveProductOther(liveId, page),
      currentPageData: state.liveOtherProducts,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(liveOtherProducts: mergedPageBreakData),
    );
  }

  Future<void> getBreakScheduleDetail(int id) async {
    executeAction(
      action: () => _liveRepository.getLeaveRequestDetail(id),
      onSuccess: (response) {
        emit(state.copyWith(currentBreakSchedule: response.data!));
      },
    );
  }

  Future<void> deleteBreakSchedule(int breakScheduleId) async {
    executeEmptyAction(
      action: () => _liveRepository.deleteLeaveRequest({
        'leave_request_id': breakScheduleId,
      }),
      onSuccess: (response) {
        DMessage.showMessage(message: response.message, type: MessageType.success);
        BasePageBreak<BreakSchedule> breakScheduleList = state.breakScheduleList;
        List<BreakSchedule> breakScheduleData = [...breakScheduleList.data];
        breakScheduleData.removeWhere((element) => element.id == breakScheduleId);
        breakScheduleList = breakScheduleList.copyWith(data: breakScheduleData);
        emit(state.copyWith(breakScheduleList: breakScheduleList, currentBreakSchedule: BreakSchedule()));
      },
    );
  }

  Future<void> getMyScheduleList({bool isInit = false}) async {
    if (state.myScheduleList.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.myScheduleList.nextPage;

    executePageBreakAction(
      isInit: isInit,
      action: () => _liveRepository.getMySchedule(page),
      currentPageData: state.myScheduleList,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(myScheduleList: mergedPageBreakData),
    );
  }

  Future<void> getMyNearestLive() async {
    executeEmptyAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _liveRepository.getMyNearestLive(),
      onSuccess: (response) {
        emit(state.copyWith(nearestLive: response.data ?? Live()));
      },
    );
  }

  Future<void> getMyScheduleDetail(int id) async {
    executeAction(
      action: () => _liveRepository.getMyScheduleDetail(id),
      onSuccess: (response) {
        emit(state.copyWith(currentLive: response.data!));
      },
    );
  }

  Future<void> updatePinProductToLive(int productId) async {
    executeAction(
      action: () => _liveRepository.updatePinProductToLive({
        'live_id': state.currentLive.id,
        'product_id': productId,
      }),
      onSuccess: (response) {
        emit(state.copyWith(currentLive: response.data!));
        getMyScheduleList(isInit: true);
        fetchLiveOtherProduct(isInit: true);
      },
    );
  }

  Future<void> getLiveBooth() async {
    if (state.currentLive.id == 0) return;
    executeAction(
      action: () => _liveRepository.getLiveBooth(state.currentLive.id),
      onSuccess: (response) {
        emit(state.copyWith(liveBooth: response.data!));
      },
    );
  }

  Future<void> fetchVoucherUsageTerms(int voucherId) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellVoucherRepository.fetchVoucherUsageTerms(voucherId),
      onSuccess: (response) {
        emit(state.copyWith(voucherUsageTerms: response.data!));
      },
    );
  }

  Future<void> markAsRead() async {
    int liveId = state.currentLive.id;
    if (liveId == 0) return;
    String deviceToken = await DeviceInfoService.deviceToken;
    executeAction(
      action: () => _liveRepository.markAsRead(liveId, deviceToken),
    );
  }

  void leaveLive() {
    executeEmptyAction(
      action: () => _liveRepository.leaveLive(state.currentLive.id),
      onSuccess: (response) => setCurrentLive(Live()),
    );
  }

  void liveLike({void Function()? onSuccess}) {
    if (state.currentLive.id == 0) return;
    executeEmptyAction(
      action: () => _liveRepository.liveLike(state.currentLive.id),
      onSuccess: (response) => onSuccess?.call(),
    );
  }
}
