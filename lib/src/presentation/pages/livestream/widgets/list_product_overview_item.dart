part of '../livestream.dart';

class ListProductOverviewItem extends StatelessWidget {
  final Product product;
  const ListProductOverviewItem({super.key, required this.product});

  String get image {
    if (product.images.isEmpty) return AppAsset.images.myWife.path;

    return product.images.first;
  }

  String pinProductText(BuildContext context) => product.isPinned ? context.text.pining : context.text.pinProduct;

  Widget pinProductWidget(BuildContext context) {
    return DButton(
      onPressed: () => context.read<LiveCubit>().updatePinProductToLive(product.id),
      text: pinProductText(context),
      size: Size(110.w, 28.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      style: AppStyle.text14.copyWith(color: product.isPinned ? AppColorLight.shadow : AppColorLight.surface),
      backgroundColor: product.isPinned ? AppCustomColor.greyDA : AppCustomColor.orangeF1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColorLight.surface,
        border: Border.all(color: AppCustomColor.greyAC, width: 0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          DCachedImage(
            borderRadius: BorderRadius.circular(10.r),
            url: image,
            width: 74.w,
            height: 74.w,
            fit: BoxFit.cover,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(product.name, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                10.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            "${context.text.inventory}: ${product.stock}",
                            style: AppStyle.text12,
                          ),
                          AppText(
                            "${product.price.currency}đ",
                            style: AppStyle.text14.copyWith(color: AppCustomColor.redD0),
                          ),
                        ],
                      ),
                    ),
                    pinProductWidget(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListProductOverHozviewItem extends StatelessWidget {
  final Product product;
  const ListProductOverHozviewItem({super.key, required this.product});

  String get image {
    if (product.images.isEmpty) return AppAsset.images.myWife.path;

    return product.images.first;
  }

  String pinProductText(BuildContext context) => product.isPinned ? context.text.pining : context.text.pinProduct;

  Widget pinProductWidget(BuildContext context) {
    return DButton(
      onPressed: () => context.read<LiveCubit>().updatePinProductToLive(product.id),
      text: pinProductText(context),
      size: Size(110.w, 28.h),
      // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      style: AppStyle.text14.copyWith(color: product.isPinned ? AppColorLight.shadow : AppColorLight.surface),
      backgroundColor: product.isPinned ? AppCustomColor.greyDA : AppCustomColor.orangeF1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      margin: EdgeInsets.only(bottom: 10.h, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DCachedImages(
                borderRadius: BorderRadius.circular(10.r),
                url: image,
                width: 140.w,
                height: 140.w,
                fit: BoxFit.cover,
              ),
            ],
          ),
          10.horizontalSpace,
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            color: AppColorLight.onSurface.op(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(product.name,
                    maxLines: 2, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
                10.verticalSpace,
                AppText(
                  "${context.text.inventory}: ${product.stock}",
                  style: AppStyle.text12.copyWith(color: Colors.white),
                ),
                AppText(
                  "${product.price.currency}đ",
                  style: AppStyle.textBold16.copyWith(
                    color: AppCustomColor.redD0,
                  ),
                ),
                pinProductWidget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
