part of '../home.dart';

class InteractionButtons extends StatelessWidget {
  final Post post;
  final bool isPreview;
  const InteractionButtons({super.key, required this.post, required this.isPreview});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.w),
      child: Builder(builder: (context) {
        return Column(
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state.user.id == post.user.id) {
                  return const SizedBox.shrink();
                }

                return InkWell(
                  onTap: () {
                    if (AppGlobalValue.accessToken.isEmpty) {
                      DNavigator.goNamed(RouteNamed.noAuth);
                      return;
                    }
                    _sendGiftTap();
                  },
                  child: Image.asset(
                    AppAsset.gif.gift.path,
                    width: 50.w,
                    height: 60.h,
                  ),
                );
              },
            ),
            10.verticalSpace,
            CustomIconButton(
              icon: post.isLikedByUser ? AppAsset.svg.heartActive : AppAsset.svg.heart,
              count: post.postLikeCount,
              onTap: () {
                if (AppGlobalValue.accessToken.isEmpty) {
                  DNavigator.goNamed(RouteNamed.noAuth);
                  return;
                }
                context.read<PostCubit>().updateLikePost(postId: post.id, isPreview: isPreview);
              },
            ),
            10.verticalSpace,
            CustomIconButton(
              icon: AppAsset.svg.comment,
              count: post.postCommentCount,
              onTap: () => _onCommentTap(context),
            ),
            10.verticalSpace,
            CustomIconButton(
              icon: post.isBookmarkedByUser ? AppAsset.svg.flagActive : AppAsset.svg.flag,
              count: post.postBookmarkCount,
              onTap: () {
                if (AppGlobalValue.accessToken.isEmpty) {
                  DNavigator.goNamed(RouteNamed.noAuth);
                  return;
                }
                context.read<PostCubit>().updateBookmarkPost(postId: post.id, isPreview: isPreview);
              },
            ),
            10.verticalSpace,
            CustomIconButton(
              icon: AppAsset.svg.share,
              count: -1,
              onTap: () => _onShareTap(context),
            ),
            18.verticalSpace,
            MusicDisk(post: post),
            10.verticalSpace
          ],
        );
      }),
    );
  }

  void _sendGiftTap() {
    showDModalBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: GiftBody(
        typeId: post.id,
      ),
    );
  }

  void _onCommentTap(BuildContext context) {
    context.read<VideoCubit>().checkAuthAndNavigate();
    if (AppGlobalValue.accessToken.isEmpty) return;
    TextEditingController commentController = TextEditingController();
    FocusNode focusNode = FocusNode();

    context.read<CommentCubit>()
      ..reset()
      ..initialPostComment(post: post);

    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      bodyWidget: CommentBody(
        post: post,
        commentController: commentController,
        focusNode: focusNode,
      ),
    );
  }

  void _onShareTap(BuildContext context) {
    context.read<VideoCubit>().checkAuthAndNavigate();
    if (AppGlobalValue.accessToken.isEmpty) return;
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: ShareBody(
        post: post,
        isPreview: isPreview,
        onDownload: () {
          StorageService.saveVideoFromNetwork(
            post.video,
            onSuccess: () => DMessage.showMessage(message: AppConfig.context!.text.downloadSuccess),
          );
          DNavigator.back();
        },
      ),
    );
  }
}
