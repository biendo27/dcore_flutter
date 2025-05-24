part of '../../livestream.dart';

class LiveScheduleListPage extends StatelessWidget {
  const LiveScheduleListPage({super.key});

  List<Widget> getActions(BuildContext context) {
    return [
      GradientButton(
        size: Size(110.w, 42.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
        onPressed: () {
          context.read<LiveRequestCubit>()
            ..getLivePlatforms()
            ..getLiveAreas();
          DNavigator.goNamed(RouteNamed.liveBreakRequest);
        },
        text: context.text.register,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        customChild: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAsset.images.circleButtonLight.path, width: 20.w, height: 20.w),
            5.horizontalSpace,
            AppText(context.text.register, style: AppStyle.text12.copyWith(color: AppColorLight.surface)),
          ],
        ),
      ),
      15.horizontalSpace,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.liveScheduleList,
      isLoading: context.select((LiveCubit cubit) => cubit.state.isLoading),
      onLoadMore: () => context.read<LiveCubit>().getMyScheduleList(),
      onRefresh: () async => context.read<LiveCubit>()
        ..getMyScheduleList(isInit: true)
        ..getMyNearestLive(),
      actions: getActions(context),
      body: BlocBuilder<LiveCubit, LiveState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.nearestLive.id != 0) ...[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  color: AppColorLight.surface,
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: AppText(
                    context.text.nearest,
                    style: AppStyle.text12,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: LiveScheduleListItem(
                    liveData: state.nearestLive,
                    latestLiveId: state.nearestLive.id,
                  ),
                ),
                5.verticalSpace,
              ],
              const LiveScheduleBody(),
            ],
          );
        },
      ),
    );
  }
}
