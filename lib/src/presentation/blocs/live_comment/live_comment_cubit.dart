part of '../blocs.dart';

@lazySingleton
class LiveCommentCubit extends Cubit<LiveCommentState> with CubitActionMixin {
  final ILiveRepository _liveRepository;
  CountDownController countDownController = CountDownController(initialCountdown: 0);
  LiveCommentCubit(this._liveRepository) : super(LiveCommentState.initial());

  void reset() => emit(LiveCommentState.initial());
  void setCurrentLive(Live live) => emit(state.copyWith(currentLive: live));
  void setAllCommentLoaded(bool isAllCommentLoaded) => emit(state.copyWith(isAllCommentLoaded: isAllCommentLoaded));
  void setPinTime(int pinTime) => emit(state.copyWith(pinTime: pinTime));
  void setPinComment(Comment comment) async {
    LiveExtraInfo liveExtraInfo = state.liveExtraInfo.copyWith(
      pinned: comment,
    );
    emit(state.copyWith(liveExtraInfo: liveExtraInfo));
  }

  void fetchLiveExtraInfo() async {
    executeAction(
      action: () => _liveRepository.getLiveExtraInfo(state.currentLive.id),
      onSuccess: (response) {
        emit(state.copyWith(liveExtraInfo: response.data!));
        final List<Comment> comments = [...state.liveComments.data];
        Comment comment = Comment(
          content: response.data!.term,
          user: AppUser(
            name: '',
            image: AppAsset.images.logo.path,
          ),
        );
        comments.insert(0, comment);
        emit(state.copyWith(liveComments: state.liveComments.copyWith(data: comments)));
      },
    );
  }

  void fetchListComment({bool isInit = false}) async {
    if (state.liveComments.isLastPage && !isInit) return;
    int page = isInit ? 1 : state.liveComments.nextPage;
    int liveId = state.currentLive.id;
    executePageBreakAction(
      isInit: isInit,
      action: () => _liveRepository.getListComment(liveId, page),
      currentPageData: state.liveComments,
      onSuccess: (response) => fetchLiveExtraInfo(),
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(liveComments: mergedPageBreakData),
    );
  }

  void loadOldComment() async {
    if (state.isAllCommentLoaded) return;
    if (state.lastCommentId == 0) return;
    executeListAction(
      action: () => _liveRepository.loadOldComment(state.lastCommentId),
      onSuccess: (response) {
        if (response.data.isEmpty) {
          setAllCommentLoaded(true);
          return;
        }
        final List<Comment> comments = [...state.liveComments.data];
        comments.addAll(response.data);
        emit(state.copyWith(liveComments: state.liveComments.copyWith(data: comments)));
      },
    );
  }

  void createComment(String content) async {
    executeAction(
      action: () => _liveRepository.createComment({
        'live_id': state.currentLive.id,
        'message': content,
      }),
    );
  }

  void addComment(Comment comment) {
    final List<Comment> comments = [...state.liveComments.data];
    comments.insert(0, comment);
    emit(state.copyWith(liveComments: state.liveComments.copyWith(data: comments)));
  }

  void updatePinCommentToLive(int commentId) async {
    executeAction(
      action: () => _liveRepository.updatePinCommentToLive(state.currentLive.id, commentId),
      onSuccess: (response) {
        if (state.pinTime == 0) return;
        LiveExtraInfo liveExtraInfo = state.liveExtraInfo.copyWith(pinned: response.data!);
        emit(state.copyWith(liveExtraInfo: liveExtraInfo));

        countDownController = CountDownController(
          initialCountdown: state.pinTime,
          onEndCount: () {
            updatePinCommentToLive(commentId);
            setPinTime(0);
          },
        );
        countDownController.start();
      },
    );
  }

  void removePinCommentFromLive(int commentId) async {
    executeAction(
      action: () => _liveRepository.updatePinCommentToLive(state.currentLive.id, commentId),
      onSuccess: (response) {
        LiveExtraInfo liveExtraInfo = state.liveExtraInfo.copyWith(pinned: Comment());
        countDownController.stop();
        countDownController = CountDownController(initialCountdown: 0);
        emit(state.copyWith(liveExtraInfo: liveExtraInfo, pinTime: 0));
      },
    );
  }
}
