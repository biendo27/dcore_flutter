part of 'repositories.dart';

abstract interface class INotificationRepository {
  Future<BaseResponse<AppNotificationList>> fetchNotificationList();
  Future<BaseResponse<BasePageBreak<AppNotification>>> fetchNewFollowerNotificationDetail(int page);
  Future<BaseResponse<BasePageBreak<AppNotification>>> fetchActivityNotificationDetail(int page);
  Future<BaseResponse<BasePageBreak<AppSystemNotification>>> fetchSystemNotificationDetail(int page);
  Future<BaseResponse<BasePageBreak<AppUser>>> fetchSuggestUser(int page);
  Future<PushNotificationResponse> pushNotificationToSingleUser(Map<String, dynamic> pushNotification);
}
