part of '../livestream.dart';

enum CommentMenuOption {
  pin;

  String get label {
    return switch (this) {
      CommentMenuOption.pin => AppConfig.context?.text.pin ?? '',
    };
  }
}

class LivestreamCommentItem extends StatelessWidget {
  final LiveRole liveRole;
  final Comment comment;
  final bool isPinned;

  const LivestreamCommentItem({
    super.key,
    required this.liveRole,
    required this.comment,
    this.isPinned = false,
  });

  bool _isHostCurrentLive(BuildContext context) {
    AppUser host = context.read<LiveCubit>().state.currentLive.user;
    AppUser currentUser = context.read<UserCubit>().state.user;
    return currentUser.isHostCurrentLive(host.id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => showCommentOption(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DCachedImage(
            url: comment.user.image,
            width: 30.w,
            height: 30.w,
            borderRadius: BorderRadius.circular(15.r),
          ),
          10.horizontalSpace,
          Container(
            padding: EdgeInsets.all(8.w),
            margin: EdgeInsets.only(bottom: 3.h),
            decoration: BoxDecoration(
              color: AppColorLight.onSurface.op(0.5),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (comment.user.name.isNotEmpty)
                  Row(
                    children: [
                      AppText(
                        comment.user.name,
                        style: AppStyle.textBold14.copyWith(color: AppColorLight.onPrimary),
                        maxLines: 1,
                      ),
                      5.horizontalSpace,
                      if (comment.user.isHost) ...[Icon(Icons.verified, color: AppCustomColor.blue17, size: 15.sp)],
                      5.horizontalSpace,
                      if (isPinned) ...[
                        Icon(Icons.push_pin, color: AppCustomColor.blue1F, size: 15.sp),
                        5.horizontalSpace,
                      ],
                      if (isPinned && _isHostCurrentLive(context)) ...[
                        CountdownTimerWidget(
                          countdownController: context.read<LiveCommentCubit>().countDownController,
                          style: AppStyle.textBold16.copyWith(color: AppColorLight.onPrimary),
                        ),
                      ],
                    ],
                  ),
                LivestreamCommentItemBody(content: comment.content),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCommentOption(BuildContext context) {
    if (comment.user.id == 0) return;
    if (!_isHostCurrentLive(context)) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColorLight.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 5.h,
              margin: EdgeInsets.only(top: 8.h),
              decoration: BoxDecoration(color: AppCustomColor.greyF2, borderRadius: BorderRadius.circular(10)),
            ),
            10.verticalSpace,
            ListTile(
              leading: const Icon(Icons.push_pin, color: AppColorLight.shadow),
              title: AppText(
                !isPinned ? context.text.pinComment : context.text.unPinComment,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if (isPinned) {
                  context.read<LiveCommentCubit>().removePinCommentFromLive(comment.id);
                  DNavigator.back();
                  return;
                }

                DNavigator.back();
                _showTimePicker(context); // Gọi menu chọn thời gian
              },
            ),
            const Divider(),
            InkWell(
              onTap: () => DNavigator.back(),
              child: Center(
                child: AppText(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  context.text.cancel,
                  style: AppStyle.textBold16.copyWith(color: AppCustomColor.blue3C),
                ),
              ),
            ),
            10.verticalSpace,
          ],
        );
      },
    );
  }

  void _startPinComment(BuildContext context, {required int duration}) {
    int endTime = duration * 60;
    context.read<LiveCommentCubit>()
      ..updatePinCommentToLive(comment.id)
      ..setPinTime(endTime);

    DNavigator.back();
  }

  void _showTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColorLight.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            AppText(
              context.text.setTimePin,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            ListTile(
              title: AppText(context.text.minute(1)),
              onTap: () => _startPinComment(context, duration: 1),
            ),
            ListTile(
              title: AppText(context.text.minute(3)),
              onTap: () => _startPinComment(context, duration: 3),
            ),
            ListTile(
              title: AppText(context.text.minute(5)),
              onTap: () => _startPinComment(context, duration: 5),
            ),
            const Divider(),
            InkWell(
              onTap: () => DNavigator.back(),
              child: Center(
                child: AppText(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  context.text.cancel,
                  style: AppStyle.textBold16.copyWith(color: AppCustomColor.blue3C),
                ),
              ),
            ),
            10.verticalSpace,
          ],
        );
      },
    );
  }
}
