part of '../shop.dart';

class PinProductVideoItem extends StatelessWidget {
  const PinProductVideoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DCachedImage(
            borderRadius: BorderRadius.circular(10.r),
            url: AppAsset.images.myWife.path,
            fit: BoxFit.cover,
            width: 74.w,
            height: 74.h,
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  "HEALTH COMPLEX".toUpperCase(),
                  style: AppStyle.text12.copyWith(
                    color: AppColorLight.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                AppText(
                  "1.000.000đ",
                  style: AppStyle.text12.copyWith(
                    color: AppCustomColor.redD0,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppAsset.svg.chat,
                      width: 20.w,
                      height: 20.h,
                    ),
                    16.horizontalSpace,
                    SvgPicture.asset(
                      AppAsset.svg.cart,
                      width: 20.w,
                      height: 20.h,
                    ),
                    GradientButton(
                      onPressed: () {},
                      size: Size(180.w, 50.h),
                      text: context.text.buyNow,
                      style: AppStyle.text12.copyWith(
                        color: AppColorLight.surface,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
