part of '../shop.dart';

class ProductIntroInfo extends StatelessWidget {
  const ProductIntroInfo({super.key});

  Widget bookMarkIcon(BuildContext context, bool isBookmarked) {
    return GestureDetector(
      onTap: () => context.read<ProductCubit>().bookmarkProduct(),
      child: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
        size: 30.sp,
        color: isBookmarked ? AppCustomColor.orangeF1 : AppColorLight.onSurface,
      ),
    );
  }

  void _viewService() {
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: ListServiceBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Column(
          children: [
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    state.currentProductDetail.product.name.toUpperCase(),
                    style: AppStyle.text20.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 2,
                    expandFlex: 1,
                  ),
                  bookMarkIcon(context, state.currentProductDetail.product.bookmarked),
                ],
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  AppText(
                    state.currentProductDetail.product.discountedPrice.currencyVND,
                    style: AppStyle.text16.copyWith(
                      color: AppCustomColor.redD0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.horizontalSpace,
                  AppText(
                    state.currentProductDetail.product.price.currencyVND,
                    style: AppStyle.text14.copyWith(
                      color: AppCustomColor.greyAC,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  12.horizontalSpace,
                  Container(
                    color: AppCustomColor.redD0.op(0.1),
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: AppText(
                      '${state.currentProductDetail.product.discount}%',
                      style: AppStyle.text12.copyWith(
                        color: AppCustomColor.redD0,
                      ),
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    AppAsset.svg.giveCoinHand,
                    width: 12.w,
                    height: 12.h,
                    colorFilter: ColorFilter.mode(AppColorLight.onPrimary, BlendMode.srcIn),
                  ),
                  5.horizontalSpace,

                  AppText(
                    "${state.currentProductDetail.product.commissionValue} ${context.text.commission.toLowerCase()}",
                    style: AppStyle.text12.copyWith(
                      color: AppCustomColor.redD0,
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  SvgPicture.asset(AppAsset.svg.star, width: 10.w, height: 10.h),
                  5.horizontalSpace,
                  AppText(
                    '${state.currentProductDetail.product.averageRating} | ${context.text.sold} ${state.currentProductDetail.product.sold.shortCurrency}',
                    style: AppStyle.text12,
                    onTap: () {
                      context.read<ReviewCubit>()
                        ..setProduct(state.currentProductDetail.product)
                        ..getProductReview();
                      DNavigator.goNamed(RouteNamed.productReview);
                    },
                  ),
                  Spacer(),
                  SvgPicture.asset(AppAsset.svg.freeShipping, width: 20.w, height: 20.h),
                  5.horizontalSpace,
                  AppText('${context.text.deliveryTime}: ${state.currentProductDetail.product.deliveryTime}',
                      style: AppStyle.text12),
                ],
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: _viewService,
                child: Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                      size: 15.sp,
                      color: AppCustomColor.orangeF1.op(0.67),
                    ),
                    5.horizontalSpace,
                    AppText(context.text.easyPayment, style: AppStyle.text10),
                    // Spacer(),
                    // Icon(
                    //   Icons.error_outline,
                    //   size: 15.sp,
                    //   color: AppCustomColor.orangeF1.op(0.67),
                    // ),
                    // 5.horizontalSpace,
                    // AppText(context.text.easyCancelOrder, style: AppStyle.text10),
                    //   Spacer(),
                    15.horizontalSpace,
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 15.sp,
                      color: AppCustomColor.orangeF1.op(0.67),
                    ),
                    5.horizontalSpace,
                    AppText(context.text.supportTeam, style: AppStyle.text10),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
          ],
        );
      },
    );
  }
}
