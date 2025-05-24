part of 'repositories.dart';

@LazySingleton(as: INotificationRepository)
class NotificationRepository with DataStateConvertible implements INotificationRepository {
  final NotificationApi _notificationApi;
  NotificationRepository(this._notificationApi);

  @override
  Future<BaseResponse<AppNotificationList>> fetchNotificationList() {
    return request(apiCall: _notificationApi.fetchNotificationList);
  }

  @override
  Future<BaseResponse<BasePageBreak<AppNotification>>> fetchNewFollowerNotificationDetail(int page) {
    return request(apiCall: () => _notificationApi.fetchNewFollowerNotificationDetail(page));
  }

  @override
  Future<BaseResponse<BasePageBreak<AppNotification>>> fetchActivityNotificationDetail(int page) {
    return request(apiCall: () => _notificationApi.fetchActivityNotificationDetail(page));
  }

  @override
  Future<BaseResponse<BasePageBreak<AppSystemNotification>>> fetchSystemNotificationDetail(int page) {
    return request(apiCall: () => _notificationApi.fetchSystemNotificationDetail(page));
  }

  @override
  Future<BaseResponse<BasePageBreak<AppUser>>> fetchSuggestUser(int page) {
    return request(apiCall: () => _notificationApi.fetchSuggestUser(page));
  }

  @override
  Future<PushNotificationResponse> pushNotificationToSingleUser(Map<String, dynamic> pushNotification) {
    return _notificationApi.pushNotificationToSingleUser(pushNotification);
  }
}
