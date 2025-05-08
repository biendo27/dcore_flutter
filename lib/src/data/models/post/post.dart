part of '../models.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    @Default(0) int id,
    @Default('') String description,
    @Default('') String video,
    @Default([]) List<String> images,
    @Default('') String thumbnail,
    @Default(0) int videoViewCount,
    @Default(false) bool isTrending,
    @Default(false) bool canComment,
    @Default(false) bool canSave,
    @Default('') String language,
    @Default('') String privacy,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(null) DateTime? deletedAt,
    @Default(0) int postLikeCount,
    @Default(0) int postCommentCount,
    @Default(0) int postBookmarkCount,
    @Default(false) bool isLikedByUser,
    @Default(false) bool isBookmarkedByUser,
    @Default(false) bool isPostAuthorFolowwedByUser,
    @Default(Sound()) Sound sound,
    @Default([]) List<HashTag> hashTags,
    @Default(AppUser()) AppUser user,
    @Default(Product()) Product product,
    @Default('') String link,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
abstract class PostParam with _$PostParam {
  const factory PostParam({
    @Default(0) int soundId,
    @Default('') String description,
    @Default([]) List<int> hashTags,
    @Default(true) bool canComment,
    @Default(true) bool canSave,
    @Default('') String language,
    @Default('') String privacy,
    @Default('') String video,
    @Default('') String thumbnail,
    @Default(0) int productId,
  }) = _PostParam;

  factory PostParam.fromJson(Map<String, dynamic> json) => _$PostParamFromJson(json);
}

enum PostType {
  following,
  friend,
  trending;

  String get name {
    return switch (this) {
      PostType.following => 'following',
      PostType.friend => 'friend',
      PostType.trending => 'trending',
    };
  }
}

extension PostX on Post {
  String get hashtagsString {
    return hashTags.map((e) => '#${e.name}').join(' ');
  }
}
