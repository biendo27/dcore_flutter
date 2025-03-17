part of '../blocs.dart';

@lazySingleton
class HashtagCubit extends Cubit<HashtagState> with CubitActionMixin<HashtagState> {
  final IHashtagRepository _hashtagRepository;

  HashtagCubit(this._hashtagRepository) : super(HashtagState.initial());

  void reset() {
    emit(HashtagState.initial());
  }

  Future<void> fetchHashtagList({String? search}) async {
    if (state.hashtags.isLastPage) return;

    final searchQuery = search ?? state.searchQuery;
    if (search != null) {
      emit(state.copyWith(
        searchQuery: search,
        hashtags: const BasePageBreak<HashTag>(),
      ));
    }

    int page = state.hashtags.nextPage;

    executePageBreakAction(
      action: () => _hashtagRepository.fetchHashtagList(page, searchQuery),
      currentPageData: state.hashtags,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(hashtags: mergedPageBreakData),
    );
  }

  void clearSearch() {
    emit(state.copyWith(
      searchQuery: '',
      hashtags: const BasePageBreak<HashTag>(),
    ));
    fetchHashtagList();
  }
}
