part of '../shop.dart';

class ProductOtherInfo extends StatelessWidget {
  const ProductOtherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShopTitleItem(
          title: context.text.otherProduct,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          isViewAll: false,
        ),
        10.verticalSpace,
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return GridView.builder(
              padding: EdgeInsets.only(bottom: 16.h, left: 10.w, right: 10.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: state.currentProductDetail.products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ProductItem(product: state.currentProductDetail.products[index]);
              },
            );
          },
        ),
      ],
    );
  }
}
