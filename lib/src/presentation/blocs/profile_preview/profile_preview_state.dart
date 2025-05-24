part of '../blocs.dart';

@freezed
abstract class ProfilePreviewState with _$ProfilePreviewState {
  const factory ProfilePreviewState({
    @Default(false) bool isLoading,
    @Default(AppUser()) AppUser user,
    @Default(BasePageBreak<Post>()) BasePageBreak<Post> userPosts,
    @Default(BasePageBreak<Post>()) BasePageBreak<Post> userBookmarkPosts,
    @Default(BasePageBreak<Post>()) BasePageBreak<Post> userLikePosts,
    @Default(BasePageBreak<Sound>()) BasePageBreak<Sound> userBookmarkSounds,
    @Default(BasePageBreak<MediaFilter>()) BasePageBreak<MediaFilter> userBookmarkFilters,
    @Default(BasePageBreak<Product>()) BasePageBreak<Product> userBookmarkProducts,
  }) = _ProfilePreviewState;

  factory ProfilePreviewState.initial() => ProfilePreviewState();
  factory ProfilePreviewState.fromJson(Map<String, dynamic> json) => _$ProfilePreviewStateFromJson(json);
}
