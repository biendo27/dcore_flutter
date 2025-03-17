part of '../livestream.dart';

class LiveBreakListItem extends StatelessWidget {
  final LiveRequest breakSchedule;
  const LiveBreakListItem({
    super.key,
    required this.breakSchedule,
  });

  String get breakTime {
    return breakSchedule.endAt!.diffTime(breakSchedule.startAt!);
  }

  Color get statusColor {
    return switch (breakSchedule.status) {
      BreakScheduleStatus.pending => AppCustomColor.orangeF1,
      BreakScheduleStatus.approved => AppCustomColor.green0F,
      BreakScheduleStatus.rejected => AppCustomColor.redD0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<LiveRequestCubit>().setCurrentLiveRequest(breakSchedule);
        context.pushNamed(RouteNamed.liveBreakDetail);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.h, vertical: 5.h),
        height: 75.h,
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(AppAsset.images.circleButtonLight.path, width: 13.w, height: 13.w),
                5.horizontalSpace,
                AppText(
                  breakTime,
                  style: AppStyle.text12.copyWith(color: AppColorLight.surface),
                ),
                if (breakSchedule.status == BreakScheduleStatus.pending) ...[
                  Spacer(),
                  AppText(
                    context.text.clear,
                    style: AppStyle.text12.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                    onTap: () {
                      context.read<LiveRequestCubit>().deleteLiveRequest(breakSchedule.id);
                      DNavigator.back();
                    },
                  ),
                ],
              ],
            ),
            AppText(
              breakSchedule.livePlatform.name,
              style: AppStyle.text12.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
            ),
            AppText(
              breakSchedule.area.name,
              style: AppStyle.text10.copyWith(color: AppColorLight.surface),
            ),
          ],
        ),
      ),
    );
  }
}
