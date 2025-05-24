part of '../blocs.dart';

@lazySingleton
class LiveEventCubit extends Cubit<LiveEventState> with CubitActionMixin<LiveEventState> {
  final ILiveRepository _liveRepository;
  LiveEventCubit(this._liveRepository) : super(LiveEventState.initial());

  void getLiveEventList({bool isInit = false}) async {
    if (state.liveEvent.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.liveEvent.nextPage;
    executePageBreakAction(
      isInit: isInit,
      action: () => _liveRepository.getLiveEventList(page),
      currentPageData: state.liveEvent,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(liveEvent: mergedPageBreakData),
    );
  }

  void subscribeLiveEvent(int liveId, {required void Function()? onSuccess}) async {
    executeAction(
      action: () => _liveRepository.liveEventSubscribe(liveId),
      onSuccess: (data) {
        DMessage.showMessage(message: data.message, type: MessageType.success);
        getLiveEventList(isInit: true);
        onSuccess?.call();
      },
    );
  }
}
