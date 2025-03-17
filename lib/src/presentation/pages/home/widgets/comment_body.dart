part of '../home.dart';

class CommentBody extends StatelessWidget {
  final Post post;
  final TextEditingController commentController;
  final FocusNode focusNode;
  const CommentBody({super.key, required this.post, required this.commentController, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    AppUser user = context.read<UserCubit>().state.user;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75 - MediaQuery.viewInsetsOf(context).bottom,
      child: Column(
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                20.horizontalSpace,
                AppText(
                  AppConfig.context!.text.comment,
                  expandFlex: 1,
                  style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () => DNavigator.back(),
                  child: Icon(
                    FontAwesomeIcons.circleXmark,
                    size: 20.sp,
                    color: AppColorLight.onSurface,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is! ScrollEndNotification) return false;
                if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
                context.read<CommentCubit>().fetchPostComment();
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () async => context.read<CommentCubit>().reloadPostComment(),
                child: BlocBuilder<CommentCubit, CommentState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const AppLoading();
                    }

                    if (!post.canComment) {
                      return NoData(message: context.text.noComment);
                    }

                    if (state.comments.data.isEmpty) {
                      return const NoData();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      shrinkWrap: true,
                      itemCount: state.comments.data.length,
                      itemBuilder: (context, index) {
                        return CommentItem(
                          comment: state.comments.data[index],
                          focusNode: focusNode,
                          isReply: false,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          if (post.canComment)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user.avatarWidget(
                    width: 40.w,
                    height: 40.w,
                    borderRadius: BorderRadius.circular(100.r),
                    onTap: () {
                      // if (post.user.id == AppConfig.context!.read<UserCubit>().state.user.id) return;
                      // AppConfig.context!.read<ProfilePreviewCubit>().fetchProfile(userId: post.user.id);
                      // DNavigator.goNamed(RouteNamed.profilePreview);
                    },
                  ),
                  12.horizontalSpace,
                  DTextField(
                    expandFlex: 1,
                    controller: commentController,
                    focusNode: focusNode,
                    hint: AppConfig.context!.text.addComment,
                    readOnly: !post.canComment,
                    // suffix: Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     AppText(
                    //       "@",
                    //       onTap: () {},
                    //       style: AppStyle.text16.copyWith(
                    //         color: AppColorLight.onSurface,
                    //       ),
                    //     ),
                    //     12.horizontalSpace,
                    //     SvgPicture.asset(AppAsset.svg.emoij, width: 20.w),
                    //     15.horizontalSpace,
                    //   ],
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: AppCustomColor.greyF2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: AppCustomColor.greyF2),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: AppCustomColor.greyF2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: AppCustomColor.greyF2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: AppCustomColor.greyF2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 15.h),
                    child: AppText(
                      AppConfig.context!.text.send,
                      style: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
                      onTap: () {
                        context.read<CommentCubit>().createComment(content: commentController.text);
                        focusNode.unfocus();
                        commentController.clear();
                      },
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
