part of '../shop.dart';

class ProductReviewInfo extends StatelessWidget {
  const ProductReviewInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (!state.hasReview) return const SizedBox.shrink();

        return Column(
          children: [
            ShopTitleItem(
              title: context.text.productReview,
              onTap: () {
                context.read<ReviewCubit>()
                  ..setProduct(state.currentProductDetail.product)
                  ..getProductReview();
                DNavigator.goNamed(RouteNamed.productReview);
              },
              bonus: Row(
                children: [
                  SvgPicture.asset(AppAsset.svg.star, width: 10.w, height: 10.h),
                  2.horizontalSpace,
                  AppText(
                    '${state.currentProductDetail.product.averageRating} (${state.currentProductDetail.product.totalRatings.shortCurrency} ${context.text.evaluate.toLowerCase()})',
                    style: AppStyle.text10,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
            ),
            ...state.takeTwoReviews
                .take(3) // Giới hạn tối đa 3 phần tử
                .map((e) => ProductEvaluateItem(review: e)),
            10.verticalSpace,
          ],
        );
      },
    );
  }
}
