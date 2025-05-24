part of '../blocs.dart';

@freezed
abstract class PostState with _$PostState {
  const factory PostState({
    @Default(false) bool isLoading,
    @Default([]) List<Post> posts,
    @Default(Post()) Post currentPost,
    @Default(0) int currentIndex,
  }) = _PostState;

  factory PostState.initial() => const PostState();

  factory PostState.fromJson(Map<String, dynamic> json) => _$PostStateFromJson(json);
}

extension PostStateExtension on PostState {
  Post get currentPostFromIndex => posts[currentIndex];
}
