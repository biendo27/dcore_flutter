part of '../blocs.dart';

@lazySingleton
class LiveViewerCubit extends Cubit<LiveViewerState> {
  LiveViewerCubit() : super(LiveViewerState.initial());
  
  void reset() => emit(LiveViewerState.initial());
  void updateViewers(List<AppUser> viewers) => emit(state.copyWith(viewers: viewers));
}
