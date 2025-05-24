part of '../../shop.dart';

class ProductReviewPage extends StatelessWidget {
  const ProductReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        return SubLayout(
          isLoading: state.isLoading,
          onLoadMore: () => context.read<ReviewCubit>().getProductReview(),
          onRefresh: () => context.read<ReviewCubit>().getProductReview(isInit: true),
          customTitle: Row(
            children: [
              AppText(
                context.text.evaluate,
                style: AppStyle.text18..copyWith(fontWeight: FontWeight.w600),
              ),
              10.horizontalSpace,
              SvgPicture.asset(AppAsset.svg.star, width: 10.w, height: 10.h),
              4.horizontalSpace,
              AppText(
                '${state.product.averageRating} (${state.product.totalRatings.shortCurrency} ${context.text.evaluate.toLowerCase()})',
                style: AppStyle.text12,
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: state.reviews.data.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) {
              return ProductEvaluateItem(
                review: state.reviews.data[index],
              );
            },
          ),
        );
      },
    );
  }
}
