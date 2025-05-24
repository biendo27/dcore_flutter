part of '../blocs.dart';

@lazySingleton
class RankCubit extends Cubit<RankState> with CubitActionMixin<RankState> {
  final IRankRepository _rankRepository;

  RankCubit(this._rankRepository) : super(RankState.initial());

  void setCurrentRank(Rank rank) => emit(state.copyWith(currentRank: rank));

  Future<void> fetchRank() async {
    executeAction(
      action: () => _rankRepository.fetchRank(),
      onSuccess: (response) {
        emit(state.copyWith(rank: response.data!));
      },
    );
  }

  Future<void> fetchRankHistory() async {
    executeListAction<Rank>(
      action: () => _rankRepository.fetchRankHistory(),
      onSuccess: (response) {
        emit(state.copyWith(rankHistory: response.data));
      },
    );
  }

  Future<void> fetchRankDetail(int rankId) async {
    executeAction(
      action: () => _rankRepository.fetchRankDetail(rankId),
      onSuccess: (response) {
        emit(state.copyWith(currentRank: response.data!));
      },
    );
  }
}
