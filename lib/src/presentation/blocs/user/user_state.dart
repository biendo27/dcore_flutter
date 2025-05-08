part of '../blocs.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default(false) bool isLoading,
    @Default('') String accessToken,
    @Default(AppUser()) AppUser user,
    @Default(BasePageBreak<Post>()) BasePageBreak<Post> userPosts,
    @Default(BasePageBreak<Post>()) BasePageBreak<Post> userLikePosts,
    @Default(BasePageBreak<Post>()) BasePageBreak<Post> userBookmarkPosts,
    @Default(BasePageBreak<Sound>()) BasePageBreak<Sound> userBookmarkSounds,
    @Default(BasePageBreak<MediaFilter>()) BasePageBreak<MediaFilter> userBookmarkFilters,
    @Default(BasePageBreak<Product>()) BasePageBreak<Product> userBookmarkProducts,
  }) = _UserState;

  factory UserState.initial() => UserState();
  factory UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);
}
