part of '../blocs.dart';

@lazySingleton
class EventCubit extends Cubit<EventState> with CubitActionMixin<EventState> {
  final ISellEventRepository _sellEventRepository;
  EventCubit(this._sellEventRepository) : super(EventState.initial());

  void setCurrentEvent(Event event) => emit(state.copyWith(currentEvent: event));

  void getEvents({bool isInit = false}) {
    if (state.events.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.events.nextPage;
    executePageBreakAction(
      isInit: isInit,
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _sellEventRepository.getEvents(page),
      currentPageData: state.events,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(events: mergedPageBreakData),
    );
  }
}
