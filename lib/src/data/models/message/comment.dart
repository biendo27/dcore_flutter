part of '../models.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    @Default(0) int id,
    @Default(0) int replyId,
    @Default(0) int typeId,
    @Default(CommentType.post) CommentType type,
    @Default('') String content,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(null) DateTime? deletedAt,
    @Default(0) int likesCount,
    @Default(0) int replyCount,
    @Default([]) List<Comment> replies,
    @Default(false) bool isLikedByUser,
    @Default(AppUser()) AppUser user,
    @Default(false) bool isPinned,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}

@freezed
abstract class LiveCommentSocketData with _$LiveCommentSocketData {
  const factory LiveCommentSocketData({
    @Default(Comment()) Comment message,
    @Default(Live()) Live live,
    @Default('') String channel,
    @Default('') String socket,
  }) = _LiveCommentSocketData;

  factory LiveCommentSocketData.fromJson(Map<String, dynamic> json) => _$LiveCommentSocketDataFromJson(json);
}

@JsonEnum(valueField: 'type')
enum CommentType {
  @JsonValue('post')
  post,
  @JsonValue('image')
  image,
  @JsonValue('sound')
  sound,
  @JsonValue('live')
  live,
}
