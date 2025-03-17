part of '../shop.dart';

class ShopProduct extends StatelessWidget {
  const ShopProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShopTitleItem(
          title: context.text.productToday,
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
              ..resetSelectedFilter
              ..searchProductNoFilter();
            DNavigator.goNamed(RouteNamed.resultFindProduct);
          },
        ),
        4.verticalSpace,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<StoreHomeCubit, StoreHomeState>(
            builder: (context, state) {
              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: state.storeHome.products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ProductItem(product: state.storeHome.products[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
