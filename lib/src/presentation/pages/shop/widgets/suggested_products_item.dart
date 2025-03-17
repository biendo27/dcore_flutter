part of '../shop.dart';

class SuggestedProductsItem extends StatelessWidget {
  final Product product;

  const SuggestedProductsItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductCubit>().initProductData(product);
        DNavigator.goNamed(RouteNamed.productDetail);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppCustomColor.greyAC, width: 0.2.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppCustomColor.yellowB0.op(0.25),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              padding: EdgeInsets.all(13.w),
              child: DCachedImage(
                url: product.thumbnail,
                height: 113.h,
                fit: BoxFit.fitHeight,
              ),
            ),
            AppText(
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              product.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: AppStyle.text12.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColorLight.onSurface.op(0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
