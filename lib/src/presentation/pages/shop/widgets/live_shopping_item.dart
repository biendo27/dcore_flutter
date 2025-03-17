part of '../shop.dart';

class LiveShoppingItem extends StatelessWidget {
  final Live liveData;
  const LiveShoppingItem({super.key, required this.liveData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<LiveCubit>()
          ..setCurrentLive(liveData)
          ..getLiveBooth();
        AppUser user = context.read<UserCubit>().state.user;
        context.read<LiveSettingCubit>().generateLiveToken(
            roomId: liveData.roomId,
            onSuccess: () {
              if (user.isHost && user.id == liveData.user.id) {
                context.pushNamed(RouteNamed.livestreamEmployee);
                return;
              }

              context.read<LiveCubit>().markAsRead();
              context.pushNamed(RouteNamed.livestream);
            });
      },
      child: Padding(
        padding: EdgeInsets.only(
          right: 10.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                DCachedImage(
                  url: liveData.user.image,
                  width: 0.18.sw - 28.w,
                  height: 0.18.sw - 28.w,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(50.r),
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: AppCustomColor.redD7, width: 2.w),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColorLight.onPrimary,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Icon(Icons.equalizer, color: Colors.pink, size: 15),
                ),
              ],
            ),
            4.verticalSpace,
            Center(
              child: AppText(
                liveData.user.name,
                style: AppStyle.textBold12,
                width: 0.25.sw - 20.w,
              ),
            )
          ],
        ),
      ),
    );
  }
}
