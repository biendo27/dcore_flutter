part of '../shop.dart';

class FindProductFilterDrawer extends StatelessWidget {
  final TextEditingController fromPriceController;
  final TextEditingController toPriceController;
  const FindProductFilterDrawer({super.key, required this.fromPriceController, required this.toPriceController});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 350.w,
      clipBehavior: Clip.none,
      backgroundColor: AppColorLight.surface,
      child: Column(
        children: [
          Container(
            height: 90.h,
            padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
            decoration: BoxDecoration(color: AppCustomColor.greyF5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.horizontalSpace,
                AppText(
                  context.text.filterSearch,
                  style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: DNavigator.back,
                  child: Icon(Icons.cancel_outlined, size: 20.sp),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(context.text.byEvaluate, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
                  12.verticalSpace,
                  FindProductRatingSection(),
                  24.verticalSpace,
                  AppText(context.text.byCategory, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
                  12.verticalSpace,
                  FindProductCategorySection(),
                  24.verticalSpace,
                  AppText(context.text.rangePrice, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
                  12.verticalSpace,
                  FindProductPriceRangeInput(
                    fromPriceController: fromPriceController,
                    toPriceController: toPriceController,
                  ),
                  17.verticalSpace,
                  FindProductPriceRangeSection(
                    onTap: () {
                      fromPriceController.clear();
                      toPriceController.clear();
                    },
                  ),
                  24.verticalSpace,
                  AppText(context.text.serviceAndPromotion, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
                  12.verticalSpace,
                  FindProductServicePromotionSection(),
                ],
              ),
            ),
          ),
          12.verticalSpace,
          MenuButton(
            onReset: () {
              context.read<ProductFilterCubit>().resetSelectedFilter();

              context.read<AffiliateCubit>().filterProductData();
              fromPriceController.clear();
              toPriceController.clear();
              DNavigator.back();
            },
            onApply: () {
              context.read<AffiliateCubit>().filterProductData(
                    fromPrice: fromPriceController.text.toInt,
                    toPrice: toPriceController.text.toInt,
                  );
              DNavigator.back();
            },
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
