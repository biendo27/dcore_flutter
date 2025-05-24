part of '../blocs.dart';

@lazySingleton
class UserListCubit extends Cubit<UserListState> with CubitActionMixin<UserListState> {
  final IFollowRepository _followRepository;
  UserListCubit(this._followRepository) : super(UserListState.initial());

  void resetData() => emit(UserListState.initial());

  void setPageIndex(int index) => emit(state.copyWith(pageIndex: index));

  void initData() {
    fetchSuggestUser(init: true);
    fetchFollowerUser(init: true);
    fetchFollowingUser(init: true);
    fetchFriendUser(init: true);
  }

  void searchUser(String search) {
    fetchSuggestUser(search: search);
    fetchFollowerUser(search: search);
    fetchFollowingUser(search: search);
    fetchFriendUser(search: search);
  }

  Future<void> fetchSuggestUser({bool init = false, String search = ''}) async {
    if (!init && state.suggestUser.isLastPage && search.isEmpty) return;
    int page = init || search.isNotEmpty ? 1 : state.suggestUser.nextPage;
    final userId = AppConfig.context!.read<UserCubit>().state.user.id;
    executePageBreakAction(
      isInit: init || search.isNotEmpty,
      action: () => _followRepository.fetchUserList(userId, UserType.suggested, search, page),
      currentPageData: state.suggestUser,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(suggestUser: mergedPageBreakData),
    );
  }

  Future<void> fetchFollowerUser({bool init = false, String search = ''}) async {
    if (!init && state.followerUser.isLastPage && search.isEmpty) return;
    int page = init || search.isNotEmpty ? 1 : state.followerUser.nextPage;
    final userId = AppConfig.context!.read<UserCubit>().state.user.id;
    executePageBreakAction(
      isInit: init || search.isNotEmpty,
      action: () => _followRepository.fetchUserList(userId, UserType.follower, search, page),
      currentPageData: state.followerUser,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(followerUser: mergedPageBreakData),
    );
  }

  Future<void> fetchFollowingUser({bool init = false, String search = ''}) async {
    if (!init && state.followingUser.isLastPage && search.isEmpty) return;
    int page = init || search.isNotEmpty ? 1 : state.followingUser.nextPage;
    final userId = AppConfig.context!.read<UserCubit>().state.user.id;
    executePageBreakAction(
      isInit: init || search.isNotEmpty,
      action: () => _followRepository.fetchUserList(userId, UserType.following, search, page),
      currentPageData: state.followingUser,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(followingUser: mergedPageBreakData),
    );
  }

  Future<void> fetchFriendUser({bool init = false, String search = ''}) async {
    if (!init && state.friendUser.isLastPage && search.isEmpty) return;
    int page = init || search.isNotEmpty ? 1 : state.friendUser.nextPage;
    final userId = AppConfig.context!.read<UserCubit>().state.user.id;
    executePageBreakAction(
      isInit: init || search.isNotEmpty,
      action: () => _followRepository.fetchUserList(userId, UserType.friend, search, page),
      currentPageData: state.friendUser,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(friendUser: mergedPageBreakData),
    );
  }

  Future<void> updateUserFollow(int userId, UserType type) async {
    executeEmptyAction(
      action: () => _followRepository.updateUserFollow(userId),
      onSuccess: (response) {
        if (type == UserType.suggested) {
          //* Handle suggested user list
          int index = state.suggestUser.data.indexWhere((e) => e.id == userId);
          AppUser user = state.suggestUser.data[index];
          user = response.data;
          List<AppUser> newData = [...state.suggestUser.data];
          newData[index] = user;
          emit(state.copyWith(suggestUser: state.suggestUser.copyWith(data: newData)));
          return;
        }
        if (type == UserType.follower) {
          AppConfig.context!.read<NotificationCubit>().updateNewFollowerNotification(response.data);
          int index = state.followerUser.data.indexWhere((e) => e.id == userId);
          if (index == -1) return;
          AppUser user = state.followerUser.data[index];
          user = response.data;
          List<AppUser> newFollowerData = [...state.followerUser.data];
          newFollowerData[index] = user;
          fetchFollowingUser();
          fetchFriendUser();
          emit(state.copyWith(followerUser: state.followerUser.copyWith(data: newFollowerData)));
          return;
        }
        if (type == UserType.following) {
          int index = state.followingUser.data.indexWhere((e) => e.id == userId);
          AppUser user = state.followingUser.data[index];
          user = response.data;
          List<AppUser> newData = [...state.followingUser.data];
          newData[index] = user;
          fetchFollowerUser();
          fetchFriendUser();
          emit(state.copyWith(followingUser: state.followingUser.copyWith(data: newData)));
        }
        if (type == UserType.friend) {
          int index = state.friendUser.data.indexWhere((e) => e.id == userId);
          AppUser user = state.friendUser.data[index];
          user = response.data;
          List<AppUser> newData = [...state.friendUser.data];
          newData[index] = user;
          emit(state.copyWith(friendUser: state.friendUser.copyWith(data: newData)));
        }
      },
    );
  }

  Future<void> removeSuggestion(int userId) async {
    executeEmptyAction(
      action: () => _followRepository.removeSuggestion(userId),
      onSuccess: (response) {
        List<AppUser> newData = [...state.suggestUser.data];
        newData.removeWhere((e) => e.id == userId);
        emit(state.copyWith(suggestUser: state.suggestUser.copyWith(data: newData)));
      },
    );
  }
}
