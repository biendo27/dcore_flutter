part of '../livestream.dart';

class TargetBody extends StatelessWidget {
  TargetBody({super.key});

  final List<Widget> items = [
    Image.asset(AppAsset.images.coin.path, width: 44.sp, height: 44.sp),
    Image.asset(AppAsset.images.bag.path, width: 44.sp, height: 44.sp),
    Image.asset(AppAsset.images.heart.path, width: 44.sp, height: 44.sp),
  ];

  String title(BuildContext context, int index) {
    return switch (index) {
      0 => context.text.giftCoins,
      1 => context.text.totalRevenue,
      2 => context.text.totalLikes,
      _ => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.35.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFD02027),
            Color(0xFFF58921),
          ],
          // background: linear-gradient(220.96deg, #D02027 -18.5%, #F58921 46.07%);
          stops: [-0.18, 0.46],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 26.sp, vertical: 16.sp),
      child: Column(
        children: [
          BlocBuilder<LiveCubit, LiveState>(
            builder: (context, state) {
              return Row(
                children: [
                  state.currentLive.user.avatarWidget(width: 34.w, height: 34.w),
                  8.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppText(
                              "${context.text.liveGoalOf} ${state.currentLive.user.name}",
                              style: AppStyle.text10.copyWith(color: AppColorLight.surface),
                            ),
                            5.horizontalSpace,
                            InkWell(
                              onTap: () => _viewAward(context),
                              child: Icon(Icons.error_outline, color: AppColorLight.surface, size: 12.sp),
                            ),
                          ],
                        ),
                        AppText(
                          context.text.targetNoti,
                          style: AppStyle.text10.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          13.verticalSpace,
          _targetLiveBody(context),
        ],
      ),
    );
  }

  Widget _targetLiveBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
      decoration: BoxDecoration(
        color: AppCustomColor.greyD9.op(0.25),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            "${context.text.progress}:",
            style: AppStyle.text10.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w600),
          ),
          4.verticalSpace,
          Divider(color: AppColorLight.surface.op(0.5), height: 1.sp),
          20.verticalSpace,
          BlocBuilder<LiveCubit, LiveState>(
            builder: (context, state) {
              return Row(
                children: List.generate(
                  items.length,
                  (index) => TargetItem(
                    icon: items[index],
                    progress: state.getProgressCount(index),
                    condition: state.getConditionCount(index),
                    title: title(context, index),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _viewAward(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.35.sh,
          child: AwardTargetBody(),
        );
      },
    );
  }
}
