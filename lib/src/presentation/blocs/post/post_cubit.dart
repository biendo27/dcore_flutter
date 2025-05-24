part of '../blocs.dart';

@lazySingleton
class PostCubit extends HydratedCubit<PostState> with CubitActionMixin<PostState> {
  final IPostRepository _postRepository;
  static const int _defaultPostCount = 30;
  static const int _nextPostCount = _defaultPostCount ~/ 2;

  PostCubit(this._postRepository) : super(PostState.initial());

  @override
  PostState fromJson(Map<String, dynamic> json) => PostState.fromJson(json);

  @override
  Map<String, dynamic> toJson(PostState state) => state.toJson();

  void markAsReadPost(int postId) async {
    executeEmptyAction(
      action: () async => _postRepository.markAsReadPost(
        postId: postId,
        deviceToken: await DeviceInfoService.deviceToken,
      ),
      onSuccess: (_) {},
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  Future<void> getPostDetail(int postId) async {
    await executeAction(
      action: () => _postRepository.fetchPostDetail(postId),
      onSuccess: (response) => emit(state.copyWith(currentPost: response.data!)),
      onFailure: (error) => DNavigator.back(),
    );
  }

  Future<void> previewPost(Post post) async {
    await getPostDetail(post.id);
    DNavigator.goNamed(RouteNamed.post);
  }

  Future<void> updateLikePost({required int postId, bool isPreview = false}) async {
    if (postId == 0) return;
    executeAction(
      action: () => _postRepository.updateLikePost(postId),
      onSuccess: (result) {
        if (isPreview) {
          emit(state.copyWith(currentPost: result.data!));
          return;
        }
        int currentPostIndex = state.posts.indexWhere((element) => element.id == postId);
        if (currentPostIndex == -1) return;
        List<Post> posts = [...state.posts];
        posts[currentPostIndex] = result.data!;
        emit(state.copyWith(posts: posts));
      },
    );
  }

  Future<void> updateBookmarkPost({required int postId, bool isPreview = false}) async {
    if (postId == 0) return;
    executeAction(
      action: () => _postRepository.updateBookmarkPost(postId),
      onSuccess: (result) {
        if (isPreview) {
          emit(state.copyWith(currentPost: result.data!));
          return;
        }
        int currentPostIndex = state.posts.indexWhere((element) => element.id == postId);
        if (currentPostIndex == -1) return;
        List<Post> posts = [...state.posts];
        posts[currentPostIndex] = result.data!;
        emit(state.copyWith(posts: posts));
      },
    );
  }

  Future<void> updatePostCommentNumber(int postId) async {
    if (postId == 0) return;
    Post post = Post();
    if (state.currentPost.id == postId) {
      post = state.currentPost.copyWith(postCommentCount: state.currentPost.postCommentCount + 1);
      emit(state.copyWith(currentPost: post));
    }

    List<Post> posts = [...state.posts];
    int postIndex = posts.indexWhere((element) => element.id == postId);
    if (postIndex == -1) return;
    post = posts[postIndex].copyWith(postCommentCount: posts[postIndex].postCommentCount + 1);
    posts[postIndex] = post;
    emit(state.copyWith(posts: posts));
  }

  void deletePost(int postId, {bool backToHome = false, void Function()? onSuccess}) {
    executeEmptyAction(
      action: () async => _postRepository.deletePost({'post_id': postId}),
      onSuccess: (response) {
        if (state.currentPost.id == postId) {
          emit(state.copyWith(currentPost: Post()));
          if (backToHome) DNavigator.back();
        }
        List<Post> posts = [...state.posts];
        posts.removeWhere((element) => element.id == postId);
        emit(state.copyWith(posts: posts));
        if (backToHome) DNavigator.newRoutesNamed(RouteNamed.home);
        onSuccess?.call();
      },
      onFailure: (message) => DMessage.showMessage(message: message, type: MessageType.error),
    );
  }

  void fetchPostList({
    int limit = _defaultPostCount,
    PostType postType = PostType.trending,
    bool isInit = false,
  }) async {
    int fetchLimit = isInit ? limit + _nextPostCount : limit;
    executeListAction<Post>(
      action: () async => _postRepository.fetchPostList(
        limit: fetchLimit,
        postType: postType,
        deviceToken: await DeviceInfoService.deviceToken,
      ),
      onSuccess: (response) {
        if (state.posts.isEmpty || isInit) {
          emit(state.copyWith(posts: response.data));
          setVideoControllers();
          return;
        }
        int oldLength = state.posts.length;
        List<Post> posts = [...state.posts, ...response.data];
        emit(state.copyWith(posts: posts));
        setMoreVideoControllers(response.data, oldLength);
      },
      onFailure: (message) {
        //* In case get data error, we can initialize video controllers from cached data
        if (state.posts.isNotEmpty) {
          setVideoControllers();
        }
        DMessage.showMessage(message: message, type: MessageType.error);
      },
    );
    emit(state.copyWith(currentIndex: 0));
  }

  void setVideoControllers() {
    AppConfig.context!.read<VideoCubit>().setVideoControllers(state.posts);
  }

  void setMoreVideoControllers(List<Post> posts, int oldLength) {
    AppConfig.context!.read<VideoCubit>().setMoreVideoControllers(posts, oldLength);
  }

  void changeCurrentIndex(int newIndex) {
    if (newIndex < 0 || newIndex >= state.posts.length) return;

    if (newIndex == state.posts.length - 5) {
      fetchPostList();
    }
    emit(state.copyWith(currentIndex: newIndex));
    AppConfig.context!.read<VideoCubit>().changeCurrentIndex(newIndex, state.posts[newIndex].video);
  }

  void removePostAfterReport(int postId) {
    List<Post> posts = [...state.posts];
    posts.removeWhere((element) => element.id == postId);
    emit(state.copyWith(posts: posts));
    AppConfig.context!.read<VideoCubit>().removeVideoController(postId);
  }
}
