part of '../blocs.dart';

@lazySingleton
class HomeSearchCubit extends Cubit<HomeSearchState> with CubitActionMixin<HomeSearchState> {
  final IPostRepository _postRepository;
  final IFollowRepository _followRepository;

  HomeSearchCubit(this._postRepository, this._followRepository) : super(HomeSearchState.initial());

  void reset() {
    emit(HomeSearchState.initial());
  }

  void setKeyword(String keyword) => emit(state.copyWith(keyword: keyword));

  void searchPost({bool isInit = true}) async {
    if (state.posts.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.posts.nextPage;
    String keyword = state.keyword;

    executePageBreakAction(
      isInit: isInit,
      action: () => _postRepository.searchPost(keyword, page),
      currentPageData: state.posts,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(posts: mergedPageBreakData),
    );
  }

  void searchUser({bool isInit = true}) async {
    if (state.users.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.users.nextPage;
    String keyword = state.keyword;

    executePageBreakAction(
      isInit: isInit,
      action: () => _postRepository.searchUser(keyword, page),
      currentPageData: state.users,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(users: mergedPageBreakData),
    );
  }

  void updateUserFollow(int userId) async {
    executeEmptyAction(
      action: () => _followRepository.updateUserFollow(userId),
      onSuccess: (response) {
        int index = state.users.data.indexWhere((e) => e.id == userId);
        if (index == -1) return;
        AppUser user = state.users.data[index];
        user = response.data;
        List<AppUser> newData = [...state.users.data];
        newData[index] = user;
        emit(state.copyWith(users: state.users.copyWith(data: newData)));
      },
    );
  }
}
