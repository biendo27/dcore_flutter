part of '../../livestream.dart';

class LiveScheduleDetailPage extends StatelessWidget {
  const LiveScheduleDetailPage({
    super.key,
  });

  Color background(LiveStatus status) {
    return switch (status) {
      LiveStatus.notStarted => AppCustomColor.orangeF1,
      LiveStatus.completed => AppCustomColor.green0F,
      LiveStatus.live => AppCustomColor.orangeF1,
      LiveStatus.pending => AppCustomColor.blue2B,
      LiveStatus.canceled => AppCustomColor.redD0,
    };
  }

  String statusText(BuildContext context, LiveStatus status) {
    return switch (status) {
      LiveStatus.notStarted => context.text.notStarted,
      LiveStatus.completed => context.text.complete,
      LiveStatus.live => context.text.living,
      LiveStatus.pending => context.text.processing,
      LiveStatus.canceled => context.text.cancel,
    };
  }

  List<Widget> getActions(BuildContext context, LiveStatus status) {
    return [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(color: background(status), borderRadius: BorderRadius.circular(5.r)),
        child: AppText(statusText(context, status), style: AppStyle.text12.copyWith(color: AppColorLight.surface)),
      ),
      15.horizontalSpace,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveCubit, LiveState>(
      builder: (context, state) {
        return SubLayout(
          title: context.text.liveScheduleDetail,
          actions: getActions(context, state.currentLive.status),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(state.currentLive.title, style: AppStyle.text20.copyWith(fontWeight: FontWeight.w500)),
                25.verticalSpace,
                AppText(context.text.time, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                5.verticalSpace,
                Row(
                  children: [
                    LiveTimeCard(title: context.text.from, time: state.currentLive.startAt!.timeValueString),
                    10.horizontalSpace,
                    AppText(" : ", style: AppStyle.text24.copyWith(fontWeight: FontWeight.w500)),
                    10.horizontalSpace,
                    LiveTimeCard(title: context.text.to, time: state.currentLive.endAt!.timeValueString),
                  ],
                ),
                25.verticalSpace,
                AppText(context.text.description, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                5.verticalSpace,
                AppText(state.currentLive.description, style: AppStyle.text12),
                25.verticalSpace,
                AppText(context.text.listProduct, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                10.verticalSpace,
                Expanded(
                  child: ListView.builder(
                    itemCount: state.currentLive.allProducts.length,
                    padding: EdgeInsets.only(bottom: 7.h),
                    itemBuilder: (context, index) {
                      return ListProductOverviewItem(product: state.currentLive.allProducts[index]);
                    },
                  ),
                ),
                if (state.nearestLive.id == state.currentLive.id && state.currentLive.status == LiveStatus.notStarted && state.currentLive.livePlatform.id == 1)
                  Row(
                    children: [
                      DButton(
                        text: context.text.cancel,
                        expandedFlex: 1,
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: AppCustomColor.greyE5,
                        style: AppStyle.textBold16.copyWith(color: AppColorLight.shadow),
                        onPressed: () => _onCancel(context),
                      ),
                      10.horizontalSpace,
                      GradientButton(
                        text: context.text.startLivestream,
                        expandedFlex: 1,
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          context.read<LiveSettingCubit>().setLiveStatus(LiveSettingStatus.setupLiveInfo);
                          context.read<LiveSettingCubit>().generateLiveToken(
                              roomId: state.currentLive.roomId,
                              onSuccess: () {
                                DNavigator.replaceNamed(RouteNamed.livestreamEmployee);
                              });
                        },
                      ),
                    ],
                  ),
                15.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  void _onCancel(BuildContext context) {
    TextEditingController cancelReasonController = TextEditingController();
    showDataBottomSheet(
      title: context.text.cancelLive,
      initialChildSize: 0.45,
      maxChildSize: 0.5,
      bodyWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.verticalSpace,
            AppText(context.text.cancelReason),
            5.verticalSpace,
            DTextField(
              controller: cancelReasonController,
              hint: context.text.cancelReason,
              type: DTextInputType.multiline,
              maxLines: 5,
            ),
            15.verticalSpace,
            DButton(
              text: context.text.cancel,
              onPressed: () {
                context.read<LiveCubit>().cancelLive(cancelReasonController.text);
                DNavigator.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
