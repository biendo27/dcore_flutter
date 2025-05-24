// ignore_for_file: unused_element

part of '../blocs.dart';

@lazySingleton
class VideoCubit extends Cubit<VideoState> with CubitActionMixin<VideoState> {
  static const int _initialControllerCount = 4;
  static const int _startPreloadIndex = _initialControllerCount ~/ 2;

  VideoCubit() : super(VideoState.initial());

  void toggleIsPlaying(bool isPlaying) {
    emit(state.copyWith(isPlaying: isPlaying));
  }

  Future<void> setVideoControllers(List<Post> posts) async {
    disposeAllVideoControllers();
    Map<int, VideoPlayerController> videoControllers = {};
    int videoCount = posts.length;
    for (var indexKey = 0; indexKey < videoCount; indexKey++) {
      videoControllers[indexKey] = VideoPlayerController.networkUrl(Uri.parse(posts[indexKey].video));
      await videoControllers[indexKey]?.setLooping(true);
    }
    emit(state.copyWith(isUpdateController: true));
    emit(state.copyWith(videoControllers: videoControllers, isUpdateController: false));
    initializeVideoControllers();
  }

  void setMoreVideoControllers(List<Post> newPosts, int oldLength) {
    Map<int, VideoPlayerController> videoControllers = {...state.videoControllers};
    for (var indexKey = 0; indexKey < newPosts.length; indexKey++) {
      videoControllers[oldLength + indexKey] = VideoPlayerController.networkUrl(Uri.parse(newPosts[indexKey].video))..setLooping(true);
    }
    emit(state.copyWith(isUpdateController: true));
    emit(state.copyWith(videoControllers: videoControllers, isUpdateController: false));
    LogDev.info('SET MORE VIDEO CONTROLLERS: ${state.videoControllers.length}');
  }

  Future<void> initializeVideoControllers() async {
    Map<int, VideoPlayerController> videoControllers = {...state.videoControllers};
    for (var indexKey = 0; indexKey < _initialControllerCount; indexKey++) {
      await videoControllers[indexKey]?.initialize();
      if ((videoControllers[indexKey]?.value.isInitialized ?? false) && (videoControllers[indexKey]?.value.isPlaying ?? false)) videoControllers[indexKey]?.pause();
    }
    // if ((videoControllers[0]?.value.isInitialized ?? false) && (videoControllers[0]?.value.isPlaying ?? false)) videoControllers[0]?.play();
    emit(state.copyWith(isUpdateController: true));
    emit(state.copyWith(videoControllers: videoControllers, isUpdateController: false));
  }

  void changeCurrentIndex(int newIndex, String videoUrlIndex) {
    if (newIndex > state.currentIndex) {
      _playNext(newIndex, videoUrlIndex);
    } else {
      _playPrevious(newIndex);
    }
    emit(state.copyWith(currentIndex: newIndex, isPlaying: true));
  }

  void disposeVideoControllers() {
    for (var controller in state.videoControllers.values) {
      controller.dispose();
    }
    emit(state.copyWith(isUpdateController: true));
    emit(state.copyWith(videoControllers: {}, isUpdateController: false));
  }

  void _playNext(int newIndex, String videoUrlIndex) {
    if (state.videoControllers.isEmpty) return;

    if (newIndex >= _startPreloadIndex) {
      // _disposePreviousVideoControllers(newIndex);
      _initializeNextVideoControllers(newIndex, videoUrlIndex);
    }

    state.videoControllers[state.currentIndex]?.pause();
    state.videoControllers[newIndex]?.play();
  }

  void _disposePreviousVideoControllers(int index) {
    int disposeIndex = index - _startPreloadIndex;
    if (disposeIndex < 0) return;
    disposeVideoController(disposeIndex);
  }

  void _initializeNextVideoControllers(int index, String videoUrlIndex) {
    int initializeIndex = index + _startPreloadIndex;
    if (initializeIndex >= state.videoControllers.length) return;
    initializeVideoController(initializeIndex, videoUrlIndex);
  }

  void _playPrevious(int newIndex) {
    if (state.videoControllers.isEmpty) return;

    // if (newIndex < state.posts.length && newIndex >= _startPreloadIndex) {
    // _disposeNextVideoControllers(newIndex);
    // _initializePreviousVideoControllers(newIndex);
    // }

    state.videoControllers[newIndex]?.play();
    state.videoControllers[state.currentIndex]?.pause();
  }

  void _disposeNextVideoControllers(int index) {
    int disposeIndex = index + _startPreloadIndex;
    if (disposeIndex >= state.videoControllers.length) return;
    disposeVideoController(disposeIndex);
  }

  void _initializePreviousVideoControllers(int index) {
    int initializeIndex = index - _startPreloadIndex;
    if (initializeIndex < 0) return;
    // initializeVideoController(initializeIndex);
  }

  Future<void> initializeVideoController(int index, String videoUrlIndex) async {
    if (state.videoControllers.isEmpty) return;
    Map<int, VideoPlayerController> videoControllers = {...state.videoControllers};
    // videoControllers[index] = VideoPlayerController.networkUrl(Uri.parse(videoUrlIndex))..setLooping(true);
    await videoControllers[index]?.initialize();
    if (videoControllers[index]?.value.isInitialized ?? false) videoControllers[index]?.pause();

    emit(state.copyWith(isUpdateController: true));
    emit(state.copyWith(videoControllers: videoControllers, isUpdateController: false));
  }

  void disposeVideoController(int index) {
    if (state.videoControllers.isEmpty) return;
    if (state.videoControllers[index]?.value.isPlaying ?? false) state.videoControllers[index]?.pause();
    state.videoControllers[index]?.dispose();
  }

  void disposeAllVideoControllers() {
    if (state.videoControllers.isEmpty) return;
    for (var controller in state.videoControllers.values) {
      if (controller.value.isPlaying) controller.pause();
      controller.dispose();
    }
  }

  void pauseCurrentVideoController() {
    if (state.videoControllers.isEmpty) return;
    if (state.videoControllers[state.currentIndex]?.value.isPlaying ?? false) state.videoControllers[state.currentIndex]?.pause();
  }

  void pauseAllVideoControllers() {
    for (var controller in state.videoControllers.values) {
      if (controller.value.isPlaying) controller.pause();
    }
  }

  void resumeCurrentVideoController() {
    if (state.videoControllers.isEmpty) return;
    if (state.videoControllers[state.currentIndex]?.value.isPlaying ?? false) return;
    state.videoControllers[state.currentIndex]?.play();
  }

  void removeVideoController(int index) {
    if (state.videoControllers.isEmpty) return;
    state.videoControllers[index]?.dispose();
    Map<int, VideoPlayerController> videoControllers = {...state.videoControllers};
    videoControllers.remove(index);
    emit(state.copyWith(isUpdateController: true));
    emit(state.copyWith(videoControllers: videoControllers, isUpdateController: false));
  }

  void checkAuthAndNavigate() {
    pauseAllVideoControllers();
    if (AppGlobalValue.accessToken.isEmpty) {
      DNavigator.goNamed(RouteNamed.noAuth);
    }
  }
}
