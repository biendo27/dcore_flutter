part of '../blocs.dart';

@freezed
abstract class CommentState with _$CommentState {
  const factory CommentState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingReply,
    @Default(Post()) Post currentPost,
    @Default(0) int replyId,
    @Default(BasePageBreak<Comment>()) BasePageBreak<Comment> comments,
  }) = _CommentState;
  factory CommentState.initial() => CommentState();
}
