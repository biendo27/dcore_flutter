part of '../shop.dart';

class OtherProducts extends StatelessWidget {
  const OtherProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          context.text.otherProducts,
          style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
        ),
        8.verticalSpace,
        BlocBuilder<ProductSuggestCubit, ProductSuggestState>(
          builder: (context, state) {
            return GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemCount: state.products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ProductItem(product: state.products[index]);
              },
            );
          },
        ),
      ],
    );
  }
}
