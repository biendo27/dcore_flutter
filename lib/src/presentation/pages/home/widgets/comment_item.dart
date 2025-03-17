part of '../home.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  final List<CommentItem> replies;
  final FocusNode focusNode;
  final bool isReply;
  final int level;
  const CommentItem({
    super.key,
    required this.comment,
    this.replies = const [],
    required this.focusNode,
    required this.isReply,
    this.level = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: DCachedImage(
                  url: comment.user.image,
                  width: (isReply ? 20 : 30).w,
                  height: (isReply ? 20 : 30).w,
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {},
                ),
              ),
              7.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      comment.user.name,
                      style: AppStyle.text14.copyWith(color: AppColorLight.onSurface.op(0.5)),
                    ),
                    4.verticalSpace,
                    AppText(comment.content, maxLines: 100, style: AppStyle.text12),
                    4.verticalSpace,
                    Row(
                      children: [
                        AppText(
                          comment.createdAt!.adaptLocalDate,
                          style: AppStyle.text10.copyWith(color: AppCustomColor.greyCF),
                        ),
                        26.horizontalSpace,
                        AppText(
                          context.text.reply,
                          onTap: () {
                            int replyId = level == 0 ? comment.id : comment.replyId;
                            context.read<CommentCubit>().setReplyId(replyId);
                            focusNode.requestFocus();
                          },
                          style: AppStyle.text12.copyWith(color: AppCustomColor.greyAC),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => context.read<CommentCubit>().updateLikePostComment(commentId: comment.id),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Căn giữa trong Row
                    children: [
                      Icon(
                        comment.isLikedByUser ? Icons.favorite : Icons.favorite_border,
                        size: 16.w,
                        color: comment.isLikedByUser ? AppCustomColor.redD7 : AppCustomColor.greyAC,
                      ),
                      5.horizontalSpace,
                      AppText(
                        comment.likesCount.toString(),
                        style: AppStyle.text10.copyWith(color: AppCustomColor.greyAC),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (comment.replyCount > 0 && comment.replies.isEmpty && level == 0)
            BlocBuilder<CommentCubit, CommentState>(
              builder: (context, state) {
                if (state.isLoadingReply && state.replyId == comment.id) return const AppLoading();
                return AppText(
                  context.text.viewReply(comment.replyCount),
                  style: AppStyle.text12,
                  margin: EdgeInsets.only(right: 70.w, top: 10.h),
                  onTap: () => context.read<CommentCubit>().fetchReplyComment(commentId: comment.id, level: level),
                );
              },
            ),
          if (comment.replies.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Column(
                children: comment.replies.map((e) {
                  return CommentItem(comment: e, focusNode: focusNode, isReply: true, level: level + 1);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
