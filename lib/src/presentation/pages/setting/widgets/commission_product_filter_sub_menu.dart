part of '../setting.dart';

class CommissionProductFilterSubMenu extends StatelessWidget {
  const CommissionProductFilterSubMenu({super.key});
  void viewCategory(BuildContext context) {
    showDModalBottomSheet(
      initialChildSize: 0.3,
      maxChildSize: 0.3,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: FindProductBodyBottomSheet(
        title: context.text.category,
        filterWidget: FindProductCategorySection(),
        onApply: () {
          context.read<AffiliateCubit>().filterProductData();
          DNavigator.back();
        },
        onReset: () {
          context.read<ProductFilterCubit>().changeSelectedCategory(StoreCategory());
          context.read<AffiliateCubit>().filterProductData();
          DNavigator.back();
        },
      ),
    );
  }

  void viewEvaluate(BuildContext context) {
    showDModalBottomSheet(
      initialChildSize: 0.3,
      maxChildSize: 0.3,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: FindProductBodyBottomSheet(
        title: context.text.evaluate,
        filterWidget: FindProductRatingSection(),
        onApply: () {
          context.read<AffiliateCubit>().filterProductData();
          DNavigator.back();
        },
        onReset: () {
          context.read<ProductFilterCubit>().changeSelectedRating(RatingFilter());
          context.read<AffiliateCubit>().filterProductData();
          DNavigator.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPopupMenuButton(
          title: context.text.evaluate,
          onTap: () => viewEvaluate(context),
        ),
        14.horizontalSpace,
        CustomPopupMenuButton(
          title: context.text.byCategory,
          onTap: () => viewCategory(context),
        ),
      ],
    );
  }
}
