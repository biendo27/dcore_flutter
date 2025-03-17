part of '../shop.dart';


class ProductCartOverview extends StatelessWidget {
  final Product product;
  const ProductCartOverview({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          width: 0.2.w,
          color: AppCustomColor.greyAC,
        ),
      ),
      child: Row(
        children: [
          DCachedImage(
            url: product.thumbnail,
            borderRadius: BorderRadius.circular(10.r),
            width: 74.w,
            height: 74.h,
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  product.name.toUpperCase(),
                  style: AppStyle.text14.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                20.verticalSpace,
                AppText(
                  "${context.text.inventory}: ${product.stock}",
                  style: AppStyle.text10,
                ),
                4.verticalSpace,
                AppText(
                  product.discountedPrice.currencyVND,
                  style: AppStyle.text12.copyWith(
                    color: AppCustomColor.redD0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
