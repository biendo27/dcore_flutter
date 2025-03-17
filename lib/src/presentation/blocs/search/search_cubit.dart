part of '../blocs.dart';

@lazySingleton
class SearchCubit extends Cubit<SearchState> with CubitActionMixin<SearchState> {
  final ISearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchState.initial());

  void reset() => emit(SearchState.initial());
  void setCurrentKeyword(String keyword) => emit(state.copyWith(currentKeyword: keyword));
  void setKeywords(List<SearchKeyword> keywords) => emit(state.copyWith(keywords: keywords));

  Future<void> fetchSearchHistory() async {
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _searchRepository.fetchSearchHistory(),
      onSuccess: (response) => emit(state.copyWith(searchHistory: response.data!)),
    );
  }

  Future<void> fetchListKeyword() async {
    if (state.currentKeyword.isEmpty) {
      emit(state.copyWith(keywords: []));
      return;
    }

    executeListAction(
      action: () => _searchRepository.fetchListKeyword(state.currentKeyword),
      onSuccess: (response) => emit(state.copyWith(keywords: response.data)),
    );
  }

  Future<void> saveKeywordHistory(String keyword) async {
    if (keyword.isEmpty) return;

    executeEmptyAction(
      action: () => _searchRepository.saveKeywordHistory(keyword),
      onSuccess: (response) => fetchSearchHistory(),
    );
  }

  Future<void> removeKeywordHistory(SearchKeyword keyword) async {
    executeEmptyAction(
      action: () => _searchRepository.removeKeywordHistory({'search_id': keyword.id}),
      onSuccess: (response) => fetchSearchHistory(),
    );
  }
}
