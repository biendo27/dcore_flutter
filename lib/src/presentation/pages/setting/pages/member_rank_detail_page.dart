part of '../setting.dart';

class MemberRankDetailPage extends StatelessWidget {
  const MemberRankDetailPage({
    super.key,
    required this.rank,
  });
  final Rank rank;
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: rank.name,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DCachedImage(
                  url: rank.image,
                  width: 50.w,
                  height: 50.w,
                  borderRadius: BorderRadius.circular(25.sp),
                ),
                18.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          context.text.numberOfVideos,
                          style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                        ),
                        5.verticalSpace,
                        AppText(
                          rank.videoRequired.toString(),
                          style: AppStyle.text14.copyWith(color: AppCustomColor.grey50),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    80.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          context.text.totalAmount,
                          style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                        ),
                        5.verticalSpace,
                        AppText(
                          rank.moneyRequired.currencyVND,
                          style: AppStyle.text14.copyWith(color: AppCustomColor.grey50),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            40.verticalSpace,
            HtmlWidget(
              rank.description,
              textStyle: AppStyle.text14.copyWith(color: AppCustomColor.grey50),
            ),
          ],
        ),
      ),
    );
  }
}
