part of '../models.dart';

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    @Default(NotificationType.likePost) NotificationType type,
    @Default(0) int liveId,
    @Default('') String roomId,
    @Default(0) int commentId,
    @Default(0) int replyId,
    @Default(0) int postId,
    @Default(0) int userId,
    @Default('') String userImage,
    @Default('') String comment,
    @Default('') String userName,
    @Default('') String message,
    @Default(null) DateTime? date,
    @Default('') String postThumbnail,
    @Default('') String liveThumbnail,
    @Default(null) DateTime? readAt,
    @Default(false) bool isFollowedByUser,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}

@freezed
abstract class AppNotificationList with _$AppNotificationList {
  const factory AppNotificationList({
    @Default(AppNotification()) AppNotification newFollower,
    @Default(AppNotification()) AppNotification activity,
    @Default(AppSystemNotification()) AppSystemNotification systemNotifications,
    @Default(AppNotification()) AppNotification conversations,
  }) = _AppNotificationList;

  factory AppNotificationList.fromJson(Map<String, dynamic> json) => _$AppNotificationListFromJson(json);
}

@JsonEnum(valueField: 'type')
enum NotificationType {
  @JsonValue('App\\Notifications\\LikePost')
  likePost,
  @JsonValue('App\\Notifications\\CommentPost')
  commentPost,
  @JsonValue('App\\Notifications\\ReplyComment')
  replyComment,
  @JsonValue('App\\Notifications\\FollowUser')
  followUser,
  @JsonValue('App\\Notifications\\StartLive')
  startLive,
  @JsonValue('App\\Notifications\\NewsCreated')
  newsCreated;
}
