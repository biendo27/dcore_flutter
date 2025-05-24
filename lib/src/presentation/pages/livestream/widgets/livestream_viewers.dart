part of '../livestream.dart';

class LivestreamViewer extends StatelessWidget {
  final AppUser viewer;
  final int rank;
  const LivestreamViewer({
    super.key,
    required this.viewer,
    this.rank = 0,
  });

  bool get showRankIcon => rank < 3;

  Color get rankTextColor {
    if (showRankIcon) return AppCustomColor.redD0;
    return AppColorLight.shadow;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppText((rank + 1).toString(), style: AppStyle.text16.copyWith(color: rankTextColor)),
      horizontalTitleGap: 0,
      title: Row(
        children: [
          LivestreamViewerAvatar(viewer: viewer, rank: rank),
          8.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(viewer.name, style: AppStyle.textBold14),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppColorLight.primary.op(0.1),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: DIconText(
                  spacing: 2.w,
                  icon: Image.asset(AppAsset.icons.rank.path, height: 13.w),
                  text: '${context.text.rank} ${rank + 1}',
                  textStyle: AppStyle.textBold10.copyWith(),
                  // iconPlaceholderAlignment: PlaceholderAlignment.bottom,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: AppText(
        viewer.totalGiftCoin < 1 ? '' : '${viewer.totalGiftCoin}+',
        style: AppStyle.text12.copyWith(color: AppCustomColor.grey50),
      ),
    );
  }
}

class LivestreamViewerAvatar extends StatelessWidget {
  final AppUser viewer;
  final int rank;
  final bool isHeader;

  LivestreamViewerAvatar({
    super.key,
    required this.viewer,
    this.rank = 0,
    this.isHeader = false,
  });

  final List<String> rankIcons = [
    AppAsset.icons.firstRank.path,
    AppAsset.icons.secondRank.path,
  ];

  double get avatarSize => isHeader ? 22 : 40;
  double get rankSize => isHeader ? 15.w : 20.w;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        viewer.avatarWidgetAction(
          width: avatarSize,
          height: avatarSize,
          borderRadius: BorderRadius.circular(40.r),
          onTap: () {
            if (viewer.id == context.read<UserCubit>().state.user.id) return;
            AppConfig.context!.read<ProfilePreviewCubit>()
              ..reset()
              ..setCurrentUser(viewer);
            DNavigator.goNamed(RouteNamed.profilePreview);
            if (isHeader) return;
            DNavigator.back();
          },
        ),
        if (rank < 2)
          Positioned(
            left: -5.w,
            top: -5.w,
            child: Image.asset(rankIcons[rank], width: rankSize, height: rankSize),
          ),
      ],
    );
  }
}
