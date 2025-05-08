part of '../models.dart';

@freezed
abstract class AppSystemNotification with _$AppSystemNotification {
  const factory AppSystemNotification({
    @Default(NotificationType.likePost) NotificationType type,
    @Default(0) int newsId,
    @Default('') String newsTitle,
    @Default('') String newsContent,
    @Default(null) DateTime? date,
    @Default(null) DateTime? readAt,
  }) = _AppSystemNotification;

  factory AppSystemNotification.fromJson(Map<String, dynamic> json) => _$AppSystemNotificationFromJson(json);
}
