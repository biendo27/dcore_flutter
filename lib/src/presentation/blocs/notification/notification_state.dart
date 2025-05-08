part of '../blocs.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(false) bool isLoading,
    @Default(AppNotificationList()) AppNotificationList notificationList,
    @Default(BasePageBreak<AppNotification>()) BasePageBreak<AppNotification> newFollower,
    @Default(BasePageBreak<AppNotification>()) BasePageBreak<AppNotification> activity,
    @Default(BasePageBreak<AppSystemNotification>()) BasePageBreak<AppSystemNotification> systemNotifications,
    @Default(BasePageBreak<AppNotification>()) BasePageBreak<AppNotification> conversations,
    @Default(AppNews()) AppNews news,
  }) = _NotificationState;
  factory NotificationState.initial() => NotificationState();

  factory NotificationState.fromJson(Map<String, dynamic> json) => _$NotificationStateFromJson(json);
}
