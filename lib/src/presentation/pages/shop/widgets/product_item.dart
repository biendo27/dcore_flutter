part of '../shop.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
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
            DCachedImage(
              url: product.thumbnail,
            //  height: 170.w,
              width: double.infinity,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
            ),
            7.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                    child: AppText(
                      product.name.toUpperCase(),
                      style: AppStyle.text12.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    children: [
                      AppText(
                        product.price.currencyVND,
                        style: AppStyle.text10.copyWith(
                          color: AppColorLight.onSurface.op(0.4),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAsset.svg.freeShipping, width: 20.w, height: 20.h),
                      5.horizontalSpace,
                      AppText(product.deliveryTime, style: AppStyle.text12),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      AppText(
                        product.discountedPrice.currencyVND,
                        style: AppStyle.text12.copyWith(color: AppColorLight.primary),
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAsset.svg.star, width: 8.w, height: 8.h),
                      AppText(product.averageRating.toString(), style: AppStyle.text10.copyWith(color: AppColorLight.primary)),
                      AppText(' | ${context.text.sold} ${product.sold.shortCurrency}', style: AppStyle.text10),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
