part of '../shop.dart';

class ProductFilterSubMenu extends StatelessWidget {
  const ProductFilterSubMenu({super.key});

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
          context.read<ProductFilterCubit>().searchProduct();
          DNavigator.back();
        },
        onReset: () {
          context.read<ProductFilterCubit>()
            ..changeSelectedCategory(StoreCategory())
            ..searchProduct();

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
          context.read<ProductFilterCubit>().searchProduct();
          DNavigator.back();
        },
        onReset: () {
          context.read<ProductFilterCubit>()
            ..changeSelectedRating(RatingFilter())
            ..searchProduct();
            
          DNavigator.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFilterCubit, ProductFilterState>(
      builder: (context, state) {
        return Row(
          children: [
            CustomPopupMenuButton(
              title: state.ratingSortLabel(context),
              isActive: state.isSortByRating,
              onTap: () => viewEvaluate(context),
            ),
            14.horizontalSpace,
            CustomPopupMenuButton(
              title: state.categorySortLabel(context),
              isActive: state.isSortByCategory,
              onTap: () => viewCategory(context),
            ),
          ],
        );
      },
    );
  }
}
