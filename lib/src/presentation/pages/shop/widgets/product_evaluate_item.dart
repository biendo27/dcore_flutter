part of '../shop.dart';

class ProductEvaluateItem extends StatelessWidget {
  final ProductReview review;
  const ProductEvaluateItem({
    super.key,
    required this.review,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              review.user.avatarWidget(
                width: 30.w,
                height: 30.w,
                borderRadius: BorderRadius.circular(15.r),
              ),
              10.horizontalSpace,
              AppText(
                review.user.name,
                style: AppStyle.text12.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              4.horizontalSpace,
              AppText(
                review.createdAt?.adaptLocalDate ?? '',
                style: AppStyle.text10,
              ),
              Spacer(),
              EvaluateStarList(numEvaluateStar: review.rating.toInt()),
            ],
          ),
          5.verticalSpace,
          HtmlWidget(
            review.content,
            textStyle: AppStyle.text12,
          ),
          5.verticalSpace,
          review.images.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: review.images
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: DCachedImage(
                              url: e,
                              height: 100.h,
                              fit: BoxFit.cover,
                              enablePhotoView: false,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
