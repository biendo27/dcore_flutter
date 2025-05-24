part of '../livestream.dart';

class LiveEventItem extends StatelessWidget {
  final Live event;
  const LiveEventItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0.w),
      decoration: BoxDecoration(
        color: AppColorLight.onPrimary,
        borderRadius: BorderRadius.circular(16.0.sp),
        boxShadow: [
          BoxShadow(
            color: AppColorLight.shadow.op(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DCachedImage(
            url: event.thumbnail,
            width: double.infinity,
            height: 132.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.sp)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(event.title, style: AppStyle.textBold16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DIconText(
                      icon: event.user.avatarWidget(width: 20, height: 20),
                      text: event.user.name,
                      expandFlex: 1,
                    ),
                    AppText(
                      event.startAt!.diffTime(event.endAt!),
                      style: AppStyle.text14.copyWith(color: AppColorLight.shadow.op(0.6)),
                    ),
                  ],
                ),
                8.verticalSpace,
                AppText(
                  context.text.description,
                  style: AppStyle.text14.copyWith(color: AppColorLight.shadow.op(0.5), fontWeight: FontWeight.w600),
                ),
                AppText(
                  event.description,
                  style: AppStyle.text12,
                  maxLines: 3,
                ),
                16.verticalSpace,
                GradientButton(
                  onPressed: () {
                    context.read<LiveEventCubit>().subscribeLiveEvent(event.id, onSuccess: () {
                      DNavigator.back();
                    });
                  },
                  gradient: event.subscribed ? LinearGradient(colors: [AppCustomColor.greyAC, AppCustomColor.greyAC]) : LinearGradient(colors: AppCustomColor.gradientButton),
                  text: event.subscribed ? context.text.registered : context.text.register,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
