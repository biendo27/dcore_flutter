part of '../shop.dart';

class ProductFilterResult extends StatelessWidget {
  const ProductFilterResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<ProductFilterCubit, ProductFilterState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return NoData();
          }

          return GridView.builder(
            padding: EdgeInsets.only(bottom: 16.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemCount: state.products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductItem(product: state.products[index]);
            },
          );
        },
      ),
    );
  }
}
