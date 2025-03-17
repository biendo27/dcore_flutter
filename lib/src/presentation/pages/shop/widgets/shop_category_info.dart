part of '../shop.dart';

class ShopCategoryInfo extends StatelessWidget {
  const ShopCategoryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        14.verticalSpace,
        ShopTitleItem(
          title: context.text.catalog,
          prefix: Container(
            margin: EdgeInsets.only(right: 9.w),
            height: 15.h,
            width: 4.w,
            decoration: BoxDecoration(
              color: AppCustomColor.orangeF1,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          onTap: () {
            context.read<ProductFilterCubit>()
              ..resetSelectedFilter()
              ..searchProductNoFilter();
            DNavigator.goNamed(RouteNamed.resultFindProduct);
          },
        ),
        4.verticalSpace,
        BlocBuilder<StoreHomeCubit, StoreHomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.horizontalSpace,
                  ...state.storeHome.categories.map((e) => CatalogItem(category: e)),
                ],
              ),
            );
          },
        ),
        15.verticalSpace,
      ],
    );
  }
}
