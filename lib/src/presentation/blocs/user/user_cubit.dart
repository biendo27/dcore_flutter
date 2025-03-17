part of '../blocs.dart';

@lazySingleton
class UserCubit extends HydratedCubit<UserState> with CubitActionMixin<UserState> {
  final IProfileRepository _profileRepository;

  UserCubit(this._profileRepository) : super(UserState.initial());

  @override
  UserState fromJson(Map<String, dynamic> json) => UserState.fromJson(json);

  @override
  Map<String, dynamic> toJson(UserState state) => state.toJson();

  void setAuthData(String auth) => emit(state.copyWith(accessToken: auth));
  void setUser(AppUser user) {
    if (user.id == 0) return;
    emit(state.copyWith(user: user));
  }

  void setUserKeepWallet(AppUser user) {
    if (user.id == 0) return;
    AppUser newUser = user;
    newUser = newUser.copyWith(wallet: state.user.wallet);
    emit(state.copyWith(user: newUser));
  }

  void setUserWallet(int wallet) => emit(state.copyWith(user: state.user.copyWith(wallet: wallet)));

  void clearData() => emit(UserState.initial());

  void initProfilePage() {
    getUser();
    fetchUserPosts(isInit: true);
    fetchUserPostBookmark(isInit: true);
    fetchUserLikePost(isInit: true);
    fetchUserSoundBookmark(isInit: true);
    fetchUserFilterBookmark(isInit: true);
    fetchUserProductBookmark(isInit: true);
  }

  Future<void> getUser() async {
    final BaseResponse<AppUser> response = await _profileRepository.fetchMyProfile();
    if (response.data == null || response.data!.id == 0) return;
    setUser(response.data!);
  }

  Future<void> fetchUserPosts({bool isInit = false}) async {
    if (state.userPosts.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.userPosts.nextPage;
    int requestUserId = state.user.id;
    executePageBreakAction(
      isInit: isInit,
      action: () => _profileRepository.fetchUserPost(requestUserId, page),
      currentPageData: state.userPosts,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(userPosts: mergedPageBreakData),
    );
  }

  Future<void> fetchUserPostBookmark({bool isInit = false}) async {
    if (state.userBookmarkPosts.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.userBookmarkPosts.nextPage;
    int requestUserId = state.user.id;
    executePageBreakAction(
      isInit: isInit,
      action: () => _profileRepository.fetchUserPostBookmarkList(requestUserId, page),
      currentPageData: state.userBookmarkPosts,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(userBookmarkPosts: mergedPageBreakData),
    );
  }

  Future<void> fetchUserLikePost({bool isInit = false}) async {
    if (state.userLikePosts.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.userLikePosts.nextPage;
    int requestUserId = state.user.id;
    executePageBreakAction(
      isInit: isInit,
      action: () => _profileRepository.fetchUserLikePost(requestUserId, page),
      currentPageData: state.userLikePosts,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(userLikePosts: mergedPageBreakData),
    );
  }

  Future<void> fetchUserSoundBookmark({bool isInit = false}) async {
    if (state.userBookmarkSounds.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.userBookmarkSounds.nextPage;
    int requestUserId = state.user.id;
    executePageBreakAction(
      isInit: isInit,
      action: () => _profileRepository.fetchUserSoundBookmarkList(requestUserId, page),
      currentPageData: state.userBookmarkSounds,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(userBookmarkSounds: mergedPageBreakData),
    );
  }

  Future<void> fetchUserFilterBookmark({bool isInit = false}) async {
    if (state.userBookmarkFilters.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.userBookmarkFilters.nextPage;
    int requestUserId = state.user.id;
    executePageBreakAction(
      isInit: isInit,
      action: () => _profileRepository.fetchUserFilterBookmarkList(requestUserId, page),
      currentPageData: state.userBookmarkFilters,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(userBookmarkFilters: mergedPageBreakData),
    );
  }

  Future<void> fetchUserProductBookmark({bool isInit = false}) async {
    if (state.userBookmarkProducts.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.userBookmarkProducts.nextPage;
    int requestUserId = state.user.id;
    executePageBreakAction(
      isInit: isInit,
      action: () => _profileRepository.fetchUserProductBookmarkList(requestUserId, page),
      currentPageData: state.userBookmarkProducts,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(userBookmarkProducts: mergedPageBreakData),
    );
  }

  void initApp({void Function()? onDone}) async {
    AppGlobalValue.accessToken = state.accessToken;
    // await Clipboard.setData(ClipboardData(text: AppGlobalValue.accessToken));

    if (AppGlobalValue.accessToken.isNotEmpty) getUser();

    DNavigator.newRoutesNamed(RouteNamed.home);
    DeepLinkService.init();
    onDone?.call();
  }
}
