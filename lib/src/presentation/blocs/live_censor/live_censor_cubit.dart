part of '../blocs.dart';

@lazySingleton
class LiveCensorCubit extends Cubit<LiveCensorState> with CubitActionMixin<LiveCensorState> {
  final ILiveCensorRepository _liveCensorRepository;

  LiveCensorCubit(this._liveCensorRepository) : super(LiveCensorState.initial());

  Future<void> getLiveCensorForm(int liveId) async {
    executeListAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _liveCensorRepository.getLiveCensorForm(liveId),
      onSuccess: (response) {
        DNavigator.goNamed(RouteNamed.liveCensorForm);
        emit(state.copyWith(censorForms: response.data));
      },
    );
  }

  List<Map<String, dynamic>> _getCensorsData(List<List<int>> points, List<List<String>> reviews) {
    List<Map<String, dynamic>> censors = [];
    for (int index = 0; index < points.length; index++) {
      for (int subIndex = 0; subIndex < points[index].length; subIndex++) {
        censors.add({
          'id': state.censorForms[index].data[subIndex].id,
          'value': points[index][subIndex],
          'comment': reviews[index][subIndex],
        });
      }
    }
    return censors;
  }

  Future<void> saveLiveCensor(int liveId, List<List<int>> points, List<List<String>> reviews) async {
    Map<String, dynamic> body = {
      'live_id': liveId,
      'censors': _getCensorsData(points, reviews),
    };

    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _liveCensorRepository.saveLiveCensor(body),
      onSuccess: (response) {
        emit(state.copyWith(currentCensorResult: response.data!));
        DNavigator.replaceNamed(RouteNamed.liveCensorResult);
      },
    );
  }

  Future<void> getLiveCensorResult(int liveId) async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _liveCensorRepository.getLiveCensorResult(liveId),
      onSuccess: (response) {
        emit(state.copyWith(currentCensorResult: response.data!));
      },
    );
  }
}
