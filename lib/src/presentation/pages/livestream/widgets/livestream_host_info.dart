part of '../livestream.dart';

class LivestreamHostInfo extends StatefulWidget {
  final LiveRole liveRole;
  const LivestreamHostInfo({
    super.key,
    this.liveRole = LiveRole.host,
  });

  @override
  State<LivestreamHostInfo> createState() => _LivestreamHostInfoState();
}

class _LivestreamHostInfoState extends State<LivestreamHostInfo> {
  void showHostProfile(AppUser user) {
    AppConfig.context!.read<ProfilePreviewCubit>()
      ..reset()
      ..setCurrentUser(user)
      ..fetchProfile();

    showDModalBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: ProfileBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Live currentLive = context.watch<LiveCubit>().state.currentLive;
    List<Widget> followButton = [
      8.horizontalSpace,
      GradientButton(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        onPressed: () {
          context.read<ProfilePreviewCubit>().followUser(userId: currentLive.user.id);
          setState(() {});
        },
        text: '+${context.text.follow}',
        style: AppStyle.textBold14.copyWith(
          color: Colors.white,
        ),
        size: Size(50.w, 20.h),
      ),
    ];

    Widget child = Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: AppColorLight.shadow.op(0.1),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        children: [
          DCachedImage(
            borderRadius: BorderRadius.circular(40.r),
            url: currentLive.user.image,
            width: 28.w,
            height: 28.w,
            fit: BoxFit.cover,
          ),
          5.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                currentLive.user.name,
                style: AppStyle.textBold10.copyWith(color: AppColorLight.onPrimary),
              ),
              DIconText(
                spacing: 2.w,
                icon: Icon(
                  Icons.favorite_rounded,
                  color: AppCustomColor.redD0,
                  size: 12.sp,
                ),
                text: currentLive.likesCount.toString(),
                textStyle: AppStyle.textBold10.copyWith(color: AppColorLight.onPrimary),
              ),
            ],
          ),
          if (currentLive.user.isFollowedByUser && widget.liveRole != LiveRole.host) ...followButton,
          5.horizontalSpace,
        ],
      ),
    );

    if (widget.liveRole != LiveRole.host) {
      child = GestureDetector(
        onTap: () => showHostProfile(currentLive.user),
        child: child,
      );
    }

    return child;
  }
}
