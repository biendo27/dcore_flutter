part of '../blocs.dart';

@lazySingleton
class ProfilePreviewCubit extends Cubit<ProfilePreviewState> with CubitActionMixin<ProfilePreviewState> {
  final IProfileRepository _profileRepository;
  final IFollowRepository _followRepository;
  ProfilePreviewCubit(this._profileRepository, this._followRepository) : super(ProfilePreviewState.initial());

  // @override
  // ProfilePreviewState fromJson(Map<String, dynamic> json) => ProfilePreviewState.fromJson(json);

  // @override
  // Map<String, dynamic> toJson(ProfilePreviewState state) => state.toJson();

  void reset() => emit(ProfilePreviewState.initial());

  void setCurrentUser(AppUser user) => emit(state.copyWith(user: user));

  Future<void> fetchProfile({int userId = 0}) async {
    int requestUserId = userId == 0 ? state.user.id : userId;
    executeAction(
      setLoadingState: (currentState, {required isLoading}) => currentState.copyWith(isLoading: isLoading),
      action: () => _profileRepository.fetchProfile(requestUserId),
      onSuccess: (response) => emit(state.copyWith(user: response.data!)),
    );
  }

  void initProfilePage() {
    fetchProfile();
    fetchUserPosts(isInit: true);
    fetchUserPostBookmark(isInit: true);
    fetchUserLikePost(isInit: true);
    fetchUserSoundBookmark(isInit: true);
    fetchUserFilterBookmark(isInit: true);
    fetchUserProductBookmark(isInit: true);
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

  Future<void> followUser({int userId = 0}) async {
    executeAction(
      action: () => _followRepository.updateUserFollow(userId),
      onSuccess: (response) {
        emit(state.copyWith(user: response.data!));
        DMessage.showMessage(message: response.message);
      },
    );
  }
}
