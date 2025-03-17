part of '../setting.dart';

class AddCommissionProductBodyBottomSheet extends StatelessWidget {
  final String title;
  final ProductAffiliate product;

  const AddCommissionProductBodyBottomSheet({
    super.key,
    required this.title,
    required this.product,
  });
  String status(BuildContext context) {
    return product.stock == 0 ? context.text.outOfStock : context.text.inStockLabel;
  }

  Color statusColor(BuildContext context) {
    return product.stock == 0 ? AppCustomColor.redD0 : AppCustomColor.green0F;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.9 - MediaQuery.viewInsetsOf(context).bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                20.horizontalSpace,
                AppText(
                  title,
                  expandFlex: 1,
                  style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () => DNavigator.back(),
                  child: Icon(
                    FontAwesomeIcons.circleXmark,
                    size: 20.sp,
                    color: AppColorLight.onSurface,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DCachedImage(
                    borderRadius: BorderRadius.circular(10.r),
                    url: product.images.first,
                    width: 1.sw,
                    height: 419.h,
                    fit: BoxFit.cover,
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          product.name.toUpperCase(),
                          style: AppStyle.text20.copyWith(fontWeight: FontWeight.w500),
                        ),
                        10.verticalSpace,
                        Row(
                          children: [
                            AppText(
                              product.discountedPrice.currencyVND,
                              style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.redD0),
                            ),
                            12.horizontalSpace,
                            AppText(
                              product.price.toString(),
                              style: AppStyle.text12.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppCustomColor.greyAC,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppCustomColor.greyAC,
                              ),
                            ),
                            12.horizontalSpace,
                            product.discount == 0
                                ? Container()
                                : Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: AppCustomColor.redD0.op(0.1),
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                    child: AppText(
                                      "-${product.discount}%",
                                      style: AppStyle.text12.copyWith(color: AppCustomColor.redD0),
                                    ),
                                  ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                color: statusColor(context).op(0.1),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: AppText(status(context), style: AppStyle.text8.copyWith(color: statusColor(context), fontWeight: FontWeight.w500)),
                            )
                          ],
                        ),
                        10.verticalSpace,
                        Row(
                          children: [
                            SvgPicture.asset(AppAsset.svg.star, width: 12.w, height: 12.h),
                            5.horizontalSpace,
                            AppText(
                              "${product.averageRating} | ${context.text.sold} ${product.sold.currency}",
                              style: AppStyle.text12.copyWith(color: AppColorLight.onSurface.op(0.75), fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            SvgPicture.asset(AppAsset.svg.giveCoinHand, width: 12.w, height: 12.h),
                            4.horizontalSpace,
                            AppText(
                              "${product.commissionValue}% ${context.text.commission.toLowerCase()}",
                              style: AppStyle.text12.copyWith(color: AppColorLight.onSurface.op(0.75), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        AppText(
                          context.text.productDescription,
                          style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                        ),
                        8.verticalSpace,
                        HtmlWidget(
                          product.description,
                          textStyle: AppStyle.text16.copyWith(fontWeight: FontWeight.w300),),
                        50.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: DHighlightText(
              text: context.text.applyCommission(500000.currencyVND),
              highlights: [500000.currencyVND],
              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
              highlightStyles: [
                AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.redD0),
              ],
            ),
          ),
          8.verticalSpace,
          DButton(
            onPressed: () {
              context.read<AffiliateCubit>().affiliateAddProduct(product.id);
            },
            text: context.text.add,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
