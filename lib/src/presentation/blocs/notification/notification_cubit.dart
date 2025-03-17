part of '../blocs.dart';

@lazySingleton
class NotificationCubit extends Cubit<NotificationState> with CubitActionMixin<NotificationState> {
  final INotificationRepository _notificationRepository;
  final INewsRepository _newsRepository;
  final IProfileRepository _profileRepository;
  NotificationCubit(this._notificationRepository, this._newsRepository, this._profileRepository) : super(NotificationState());

  // @override
  // NotificationState fromJson(Map<String, dynamic> json) => NotificationState.fromJson(json);

  // @override
  // Map<String, dynamic> toJson(NotificationState state) => state.toJson();

  void updateNewFollowerNotification(AppUser user) {
    List<AppNotification> newData = [...state.newFollower.data];
    int index = newData.indexWhere((e) => e.userId == user.id);
    if (index == -1) return;
    newData[index] = newData[index].copyWith(isFollowedByUser: user.isFollowedByUser);
    emit(state.copyWith(newFollower: state.newFollower.copyWith(data: newData)));
  }

  void goMessage(int userId) {
    executeAction(
      action: () => _profileRepository.fetchProfile(userId),
      onSuccess: (response) => AppConfig.context!.read<MessageCubit>().onChatProfile(response.data!),
    );
  }

  Future<void> fetchNotificationList() async {
    executeAction(
      action: _notificationRepository.fetchNotificationList,
      onSuccess: (response) => emit(state.copyWith(notificationList: response.data!)),
    );
  }

  Future<void> fetchNewFollowerNotificationDetail({bool init = false}) async {
    if (state.newFollower.isLastPage && !init) return;
    int page = init ? 1 : state.newFollower.nextPage;
    executePageBreakAction(
      isInit: init,
      action: () => _notificationRepository.fetchNewFollowerNotificationDetail(page),
      currentPageData: state.newFollower,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(newFollower: mergedPageBreakData),
    );
  }

  Future<void> fetchActivityNotificationDetail({bool init = false}) async {
    if (state.activity.isLastPage && !init) return;
    int page = init ? 1 : state.activity.nextPage;
    executePageBreakAction(
      isInit: init,
      action: () => _notificationRepository.fetchActivityNotificationDetail(page),
      currentPageData: state.activity,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(activity: mergedPageBreakData),
    );
  }

  Future<void> fetchSystemNotificationDetail({bool init = false}) async {
    if (state.systemNotifications.isLastPage && !init) return;
    int page = init ? 1 : state.systemNotifications.nextPage;
    executePageBreakAction(
      isInit: init,
      action: () => _notificationRepository.fetchSystemNotificationDetail(page),
      currentPageData: state.systemNotifications,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(systemNotifications: mergedPageBreakData),
    );
  }

  Future<void> fetchNewsDetail(int newsId) async {
    executeAction(
      action: () => _newsRepository.getNewsDetail(newsId),
      onSuccess: (response) => emit(state.copyWith(news: response.data!)),
    );
  }
}
