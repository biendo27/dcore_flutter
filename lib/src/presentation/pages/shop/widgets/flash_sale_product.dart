part of '../shop.dart';

class FlashSaleProduct extends StatelessWidget {
  final Product product;
  const FlashSaleProduct({
    super.key,
    required this.product,
  });

  void _buyNow(BuildContext context) {
    DNavigator.back();
    context.read<CartCubit>().setProductCart(product);
    context.read<CartCubit>().getProductByVariant(product.attributes.map((e) => e.values.first).toList());
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: CartPopupBody(type: CartPopupType.buyNow),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppCustomColor.greyAC, width: 0.2.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DCachedImage(
            borderRadius: BorderRadius.circular(10.r),
            url: product.thumbnail,
            width: 74.w,
            height: 74.w,
            fit: BoxFit.cover,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  product.name.toUpperCase(),
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                5.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppAsset.svg.star, width: 12.w, height: 12.h),
                    AppText(product.averageRating.toString(), style: AppStyle.text10.copyWith(color: AppColorLight.primary)),
                    AppText(' | ${context.text.sold} ${product.sold.shortCurrency}', style: AppStyle.text10),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            product.price.currencyVND,
                            style: AppStyle.text10.copyWith(
                              color: AppColorLight.onSurface.op(0.4),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          AppText(
                            product.discountedPrice.currencyVND,
                            style: AppStyle.text12.copyWith(color: AppCustomColor.redD0),
                          ),
                        ],
                      ),
                    ),
                    DButton(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      size: Size(114.w, 35.h),
                      text: context.text.buyNow,
                      style: AppStyle.text14.copyWith(color: AppColorLight.surface),
                      onPressed: () => _buyNow(context),
                    )
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
