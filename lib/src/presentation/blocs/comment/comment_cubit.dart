part of '../blocs.dart';

@lazySingleton
class CommentCubit extends Cubit<CommentState> with CubitActionMixin<CommentState> {
  final IPostRepository _postRepository;
  CommentCubit(this._postRepository) : super(CommentState.initial());

  void reset() => emit(CommentState.initial());
  void setCurrentPost(Post post) => emit(state.copyWith(currentPost: post));
  void setReplyId(int replyId) => emit(state.copyWith(replyId: replyId));

  Future<void> initialPostComment({required Post post, int commentId = 0}) async {
    executeAction(
      setLoadingState: (state, {required bool isLoading}) => state.copyWith(isLoading: isLoading),
      action: () => _postRepository.fetchPostComment({
        if (commentId > 0) 'comment_id': commentId,
        'post_id': post.id,
        'page': 1,
      }),
      onSuccess: (result) => emit(state.copyWith(comments: result.data!, currentPost: post)),
    );
  }

  Future<void> reloadPostComment() async {
    if (state.currentPost.id == 0) return;
    initialPostComment(post: state.currentPost);
  }

  Future<void> fetchPostComment({int commentId = 0}) async {
    if (state.currentPost.id == 0) return;
    if (state.comments.isLastPage) return;
    int page = state.comments.nextPage;

    executePageBreakAction(
      action: () => _postRepository.fetchPostComment({
        'post_id': state.currentPost.id,
        'page': page,
      }),
      currentPageData: state.comments,
      setPageBreakState: (currentState, {required mergedPageBreakData}) => currentState.copyWith(comments: mergedPageBreakData),
    );
  }

  Future<void> createComment({required String content}) async {
    if (state.currentPost.id == 0) return;
    if (state.replyId > 0) {
      createReplyComment(content: content);
      return;
    }

    executeAction(
      action: () => _postRepository.createPostComment({
        'post_id': state.currentPost.id,
        'post_content': content,
      }),
      onSuccess: (result) {
        List<Comment> newComments = [...state.comments.data, result.data!];
        BasePageBreak<Comment> newPageBreak = state.comments.copyWith(data: newComments);
        emit(state.copyWith(comments: newPageBreak, replyId: 0));
        AppConfig.context?.read<PostCubit>().updatePostCommentNumber(state.currentPost.id);
      },
    );
  }

  Future<void> createReplyComment({required String content, int level = 0}) async {
    if (state.currentPost.id == 0) return;
    executeAction(
      action: () => _postRepository.createPostComment({
        'post_id': state.currentPost.id,
        'post_content': content,
        'reply_id': state.replyId,
      }),
      onSuccess: (result) {
        List<Comment> newComments = [...state.comments.data];
        int commentIndex = newComments.indexWhere((element) => element.id == state.replyId);
        Comment comment = newComments[commentIndex];
        if (level == 0) {
          List<Comment> newReplies = [...comment.replies, result.data!];
          comment = comment.copyWith(replies: newReplies);
          newComments[commentIndex] = comment;
        }
        // else {
        //   List<Comment> newReplies = [...comment.replies, result.data!];
        //   newComments.insert(commentIndex + 1, comment.copyWith(replies: newReplies));
        // }
        emit(state.copyWith(comments: state.comments.copyWith(data: newComments), replyId: 0));
        AppConfig.context?.read<PostCubit>().updatePostCommentNumber(state.currentPost.id);
      },
    );
  }

  Future<void> fetchReplyComment({required int commentId, int level = 0}) async {
    if (state.currentPost.id == 0) return;
    if (state.comments.data.isEmpty) return;

    emit(state.copyWith(replyId: commentId));

    executeAction(
      action: () => _postRepository.fetchPostComment({
        'post_id': state.currentPost.id,
        'comment_id': commentId,
        'page': 1,
      }),
      setLoadingState: (state, {required bool isLoading}) => state.copyWith(isLoadingReply: isLoading),
      onSuccess: (result) {
        List<Comment> newComments = [...state.comments.data];
        int oldCommentIndex = newComments.indexWhere((element) => element.id == commentId);
        Comment oldComment = newComments[oldCommentIndex];
        if (level == 0) {
          List<Comment> newReplies = [...oldComment.replies, ...result.data!.data];
          oldComment = oldComment.copyWith(replies: newReplies);
          newComments[oldCommentIndex] = oldComment;
        }
        //  else {
        //   List<Comment> newReplies = [...oldComment.replies];
        //   int newRepliesIndex = newReplies.indexWhere((element) => element.id == result.data!.data[0].id);
        //   newReplies.insert(newRepliesIndex + 1, oldComment);
        //   oldComment = oldComment.copyWith(replies: newReplies);
        //   newComments[oldCommentIndex] = oldComment;
        // }
        emit(state.copyWith(comments: state.comments.copyWith(data: newComments)));
      },
    );
  }

  Future<void> updateLikePostComment({required int commentId}) async {
    if (state.currentPost.id == 0) return;
    executeAction(
      action: () => _postRepository.updateLikePostComment(commentId),
      onSuccess: (result) {
        List<Comment> newComments = [...state.comments.data];
        int commentIndex = newComments.indexWhere((element) => element.id == commentId);
        newComments[commentIndex] = result.data!;
        emit(state.copyWith(comments: state.comments.copyWith(data: newComments)));
      },
    );
  }
}
