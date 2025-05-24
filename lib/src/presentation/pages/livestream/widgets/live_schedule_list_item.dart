part of '../livestream.dart';

class LiveScheduleListItem extends StatelessWidget {
  final Live liveData;
  final int latestLiveId;
  const LiveScheduleListItem({
    super.key,
    required this.liveData,
    this.latestLiveId = 0,
  });

  Color get background {
    if (latestLiveId == liveData.id) return AppCustomColor.orangeF1;
    return switch (liveData.status) {
      LiveStatus.notStarted => AppColorLight.surface,
      LiveStatus.completed => AppCustomColor.green0F,
      LiveStatus.live => AppCustomColor.orangeF1,
      LiveStatus.pending => AppCustomColor.blue2B,
      LiveStatus.canceled => AppCustomColor.redD0,
    };
  }

  String status(BuildContext context) {
    return switch (liveData.status) {
      LiveStatus.notStarted => context.text.notStarted,
      LiveStatus.completed => context.text.complete,
      LiveStatus.live => context.text.living,
      LiveStatus.pending => context.text.processing,
      LiveStatus.canceled => context.text.cancel,
    };
  }

  bool get check => liveData.status == LiveStatus.notStarted;
  Color get color {
    if (latestLiveId == liveData.id) return AppColorLight.surface;
    return check ? AppCustomColor.orangeF1 : AppColorLight.surface;
  }

  Color get colorText {
    if (latestLiveId == liveData.id) return AppColorLight.surface.op(0.75);
    return check ? AppColorLight.shadow.op(0.75) : AppColorLight.surface.op(0.75);
  }

  Color get colorTextBold {
    if (latestLiveId == liveData.id) return AppColorLight.surface;
    return check ? AppColorLight.shadow : AppColorLight.surface;
  }

  String get icon => !check ? AppAsset.images.circleButtonLight.path : AppAsset.images.circleButton.path;

  Widget trailingTitle(BuildContext context) {
    Widget title = AppText(
      status(context),
      textAlign: TextAlign.end,
      style: AppStyle.text12.copyWith(color: color, fontWeight: FontWeight.w500),
    );

    if (liveData.status == LiveStatus.live) {
      title = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [title, 5.horizontalSpace, Icon(Icons.circle, color: AppCustomColor.redD0, size: 8.sp)],
      );
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<LiveCubit>()
          ..setCurrentLive(liveData)
          ..getMyScheduleDetail(liveData.id);
        DNavigator.goNamed(RouteNamed.liveScheduleDetail);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        icon,
                        width: 13.w,
                        height: 13.w,
                      ),
                      5.horizontalSpace,
                      AppText(
                        '${liveData.startAt?.timeValueString} - ${liveData.endAt?.timeValueString}',
                        style: AppStyle.text12.copyWith(color: colorText),
                      ),
                    ],
                  ),
                  AppText(
                    liveData.title,
                    maxLines: 1,
                    style: AppStyle.text12.copyWith(color: colorTextBold, fontWeight: FontWeight.w500),
                  ),
                  AppText(
                    liveData.description,
                    maxLines: 2,
                    style: AppStyle.text10.copyWith(color: colorText),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  trailingTitle(context),
                  10.verticalSpace,
                  StackedImages(images: liveData.productImages),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
