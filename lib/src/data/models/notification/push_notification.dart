part of '../models.dart';

@freezed
abstract class PushNotificationResponse with _$PushNotificationResponse {
  const factory PushNotificationResponse({@Default(PushNotification()) PushNotification fields}) = _PushNotificationResponse;

  factory PushNotificationResponse.fromJson(Map<String, dynamic> json) => _$PushNotificationResponseFromJson(json);
}

@freezed
abstract class PushNotification with _$PushNotification {
  const factory PushNotification({
    @Default('') String? token,
    @Default(NotificationData()) NotificationData? notification,
    @Default({}) Map<String, dynamic> data,
  }) = _PushNotification;

  factory PushNotification.fromJson(Map<String, dynamic> json) => _$PushNotificationFromJson(json);
}

@freezed
abstract class NotificationData with _$NotificationData {
  const factory NotificationData({
    @Default('') String? title,
    @Default('') String? body,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);
}
