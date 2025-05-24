part of '../setting.dart';

class MemberRankHistoryItem extends StatelessWidget {
  final Rank rankData;
  final int latestRankId;
  const MemberRankHistoryItem({
    super.key,
    required this.rankData,
    this.latestRankId = 0,
  });

  Color get background {
    if (latestRankId == rankData.id) return AppCustomColor.orangeF1;
    return AppColorLight.surface;
  }

  Color get colorText {
    if (latestRankId == rankData.id) return AppColorLight.surface.op(0.75);
    return AppColorLight.onSurface;
  }

  Color get colorTextBold {
    if (latestRankId == rankData.id) return AppColorLight.surface;
    return AppColorLight.onSurface;
  }

  String get icon => (latestRankId == rankData.id) ? AppAsset.images.circleButtonLight.path : AppAsset.images.circleButton.path;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            Expanded(
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
                        rankData.createdAt?.timeDateString ?? "",
                        style: AppStyle.text12.copyWith(color: colorText),
                      ),
                    ],
                  ),
                  AppText(
                    rankData.name,
                    maxLines: 1,
                    style: AppStyle.text12.copyWith(color: colorTextBold, fontWeight: FontWeight.w500),
                  ),
                  AppText(
                    "Chúc mừng bạn đã đạt thứ hạng",
                    maxLines: 2,
                    style: AppStyle.text10.copyWith(color: colorText),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            DCachedImage(url: rankData.image, width: 40.w, height: 40.w, borderRadius: BorderRadius.circular(25.sp)),
          ],
        ),
      ),
    );
  }
}
