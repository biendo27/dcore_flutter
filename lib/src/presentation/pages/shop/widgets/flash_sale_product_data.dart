part of '../shop.dart';

class FlashSaleProductData extends StatelessWidget {
  const FlashSaleProductData({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FlashSaleCubit, FlashSaleState>(
        builder: (context, state) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemCount: state.currentFlashSale.products.length,
            itemBuilder: (context, index) {
              return FlashSaleProduct(
                product: state.currentFlashSale.products[index],
              );
            },
          );
        },
      ),
    );
  }
}
