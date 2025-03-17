part of '../shop.dart';

class FlashSalesItem extends StatelessWidget {
  final Product product;

  const FlashSalesItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductCubit>().initProductData(product);
        DNavigator.goNamed(RouteNamed.productDetail);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DCachedImage(
              url: product.thumbnail,
              width: 0.20.sw - 28.w,
              height: 0.20.sw - 28.w,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(10.r),
            ),
            4.verticalSpace,
            AppText(
              product.discountedPrice.currencyVND,
              style: AppStyle.textBold12,
            ),
          ],
        ),
      ),
    );
  }
}
