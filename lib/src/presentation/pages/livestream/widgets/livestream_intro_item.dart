part of '../livestream.dart';

class LivestreamIntroItem extends StatelessWidget {
  final Live live;
  const LivestreamIntroItem({super.key, required this.live});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<LiveCubit>()
          ..setCurrentLive(live)
          ..getLiveBooth();
        AppUser user = context.read<UserCubit>().state.user;
        context.read<LiveSettingCubit>().generateLiveToken(
            roomId: live.roomId,
            onSuccess: () {
              if (user.isHost && user.id == live.user.id) {
                context.pushNamed(RouteNamed.livestreamEmployee);
                return;
              }

              context.read<LiveCubit>().markAsRead();
              context.pushNamed(RouteNamed.livestream);
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColorLight.surface,
          borderRadius: BorderRadius.circular(16.sp),
          border: Border.all(color: AppColorLight.outlineVariant, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                DCachedImage(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                  url: live.thumbnail,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColorLight.onSurface.op(0.4),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye, color: AppColorLight.surface, size: 16),
                        SizedBox(width: 4),
                        AppText(
                          live.viewCount.toString(),
                          style: AppStyle.text12.copyWith(color: AppColorLight.surface),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColorLight.onSurface.op(0.4),
                      // border: Border.all(color: AppColorLight.surface, width: 1.w),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AppAsset.gif.wave.path, width: 15.w, height: 15.h, color: AppColorLight.surface),
                        AppText("Live", style: AppStyle.text10.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColorLight.surface,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(live.title, style: AppStyle.text10),
                  3.verticalSpace,
                  Row(
                    children: [
                      DCachedImage(
                        url: live.user.image,
                        borderRadius: BorderRadius.circular(100),
                        width: 25.w,
                        height: 25.w,
                      ),
                      6.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(live.user.name, style: AppStyle.textBold10),
                            AppText(live.user.username, style: AppStyle.text10),
                          ],
                        ),
                      ),
                      AppText(
                        live.user.totalLikes.toString(),
                        style: AppStyle.text10.copyWith(color: AppColorLight.outlineVariant),
                      ),
                      4.horizontalSpace,
                      Icon(
                        Icons.favorite_outline_rounded,
                        color: AppColorLight.outlineVariant,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
