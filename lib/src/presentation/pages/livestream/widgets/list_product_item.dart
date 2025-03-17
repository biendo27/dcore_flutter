part of '../livestream.dart';

class ListProductItem extends StatelessWidget {
  final Product product;
  const ListProductItem({super.key, required this.product});

  String get image {
    if (product.images.isEmpty) return AppAsset.images.myWife.path;

    return product.images.first;
  }

  void _buyNow(BuildContext context) {
    DNavigator.back();
    context.read<CartCubit>().setProductCart(product);
    context.read<CartCubit>().getProductByVariant(product.attributes.map((e) => e.values.first).toList());
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: CartPopupBody(type: CartPopupType.buyNow),
    );
  }

  void _addToCart(BuildContext context) {
    DNavigator.back();
    context.read<CartCubit>().setProductCart(product);
    context.read<CartCubit>().getProductByVariant(product.attributes.map((e) => e.values.first).toList());
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: CartPopupBody(type: CartPopupType.addToCart),
    );
  }

  Widget buyProductWidget(BuildContext context) {
    return Row(
      children: [
        DButton(
          onPressed: () => _addToCart(context),
          customChild: Icon(Icons.add_shopping_cart_rounded, size: 20.w),
          size: Size(40.w, 35.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          style: AppStyle.text14.copyWith(color: AppColorLight.surface),
          backgroundColor: AppCustomColor.greyDA,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(5.r))),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        DButton(
          onPressed: () => _buyNow(context),
          text: context.text.buy,
          size: Size(70.w, 35.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          style: AppStyle.text14.copyWith(color: AppColorLight.surface),
          backgroundColor: AppCustomColor.orangeF1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(5.r))),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      margin: EdgeInsets.only(bottom: 10.h, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColorLight.surface,
        border: Border.all(color: AppCustomColor.greyAC, width: 0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DCachedImage(
            borderRadius: BorderRadius.circular(10.r),
            url: image,
            width: 94.w,
            height: 94.w,
            fit: BoxFit.cover,
            onTap: () {
              DNavigator.back();
              context.read<ProductCubit>().initProductData(product);

              DNavigator.goNamed(RouteNamed.productDetail);
            },
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(product.name, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500), maxLines: 2),
              5.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(AppAsset.svg.star, width: 12.w, height: 12.h),
                  AppText(
                    product.averageRating.rating,
                    style: AppStyle.text10.copyWith(color: AppColorLight.primary),
                  ),
                  AppText(
                    ' | ${context.text.sold} ${product.sold.shortCurrency}',
                    style: AppStyle.text10,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    product.price.currencyVND,
                    style: AppStyle.text10.copyWith(
                      color: AppColorLight.onSurface.op(0.4),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  AppText(
                    product.discountedPrice.currencyVND,
                    style: AppStyle.text12.copyWith(color: AppCustomColor.redD0),
                  ),
                ],
              ),
              buyProductWidget(context),
            ],
          ),
        ],
      ),
    );
  }
}
