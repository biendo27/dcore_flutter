part of '../livestream.dart';

class LivestreamTargetView extends StatelessWidget {
  final LiveRole liveRole;
  const LivestreamTargetView({
    super.key,
    this.liveRole = LiveRole.host,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => _viewTarget(context),
          child: Container(
            decoration: BoxDecoration(
              color: AppColorLight.shadow.op(0.1),
              borderRadius: BorderRadius.circular(5.r),
            ),
            padding: EdgeInsets.all(5.sp),
            child: GiftConditionInfo(),
          ),
        ),
        liveRole == LiveRole.host
            ? InkWell(
                onTap: () => context.read<LiveMissionCubit>().getLiveRandom(),
                child: Image.asset(
                  AppAsset.gif.award.path,
                  width: 48.sp,
                  height: 48.sp,
                ),
              )
            : Image.asset(
                AppAsset.gif.award.path,
                width: 48.sp,
                height: 48.sp,
              ),
      ],
    );
  }

  void _viewTarget(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.35.sh,
          child: TargetBody(),
        );
      },
    );
  }
}
