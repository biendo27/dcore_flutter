part of '../setting.dart';

class RankItem extends StatelessWidget {
  const RankItem({
    super.key,
    required this.rank,
    this.onTap,
  });
  final void Function()? onTap;
  final Rank rank;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => DNotiMessage.featureInDevelopment(),
      child: Container(
        padding: EdgeInsets.only(bottom: 16.w),
        child: Row(
          children: [
            DCachedImage(
              url: rank.image,
              width: 50.w,
              height: 50.w,
              borderRadius: BorderRadius.circular(25.sp),
            ),
            11.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(rank.name, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  5.verticalSpace,
                  AppText(
                    rank.description,
                    style: AppStyle.text14.copyWith(color: AppCustomColor.grey50),
                    margin: EdgeInsets.only(right: 50.w),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
            ),
          ],
        ),
      ),
    );
  }
}
