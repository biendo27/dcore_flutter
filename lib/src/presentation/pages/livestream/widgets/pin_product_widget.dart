part of '../livestream.dart';

class PinProductWidget extends StatelessWidget {
  final Product product;
  final LiveRole liveRole;
  const PinProductWidget({super.key, required this.product, required this.liveRole});

  void _buyNow(BuildContext context) {
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

  void _pinProduct(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.35.sh,
          child: PinProductBody(),
        );
      },
    );
  }

  String _getPinProductText(BuildContext context) {
    return liveRole == LiveRole.host ? context.text.pin : context.text.buy;
  }

  @override
  Widget build(BuildContext context) {
    if (!product.isPinned) return SizedBox(width: 74.w, height: 74.w);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        padding: EdgeInsets.all(5.w),
        height: 0.1.sh,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                DCachedImage(
                  url: product.images.first,
                  width: 74.w,
                  height: 74.w,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(15.r),
                  onTap: () {
                    context.read<ProductCubit>().initProductData(product);
                    DNavigator.goNamed(RouteNamed.productDetail);
                  },
                ),
                Container(
                  width: 80.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    gradient: LinearGradient(
                      colors: AppCustomColor.gradientPinProduct,
                      stops: [0.32, 1],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppAsset.gif.flame.path, width: 16.w, height: 16.h),
                      2.horizontalSpace,
                      AppText(
                        context.text.special,
                        style: AppStyle.text12.copyWith(color: AppColorLight.surface),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.textBold16,
                  ),
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
                  Spacer(),
                  Row(
                    children: [
                      AppText(
                        '${product.discountedPrice.currency}đ',
                        style: AppStyle.text18.copyWith(color: AppColorLight.primary, fontWeight: FontWeight.bold),
                      ),
                      5.horizontalSpace,
                      AppText(
                        '${product.price.currency}đ',
                        style: AppStyle.text12.copyWith(color: Colors.grey, decoration: TextDecoration.lineThrough),
                      ),
                      5.horizontalSpace,
                      AppText(
                        '(${product.discount}%)',
                        style: AppStyle.text12.copyWith(color: Colors.green),
                      ),
                      Spacer(),
                      DButton(
                        onPressed: () {
                          if (liveRole == LiveRole.host) {
                            _pinProduct(context);
                            return;
                          }
                          _buyNow(context);
                        },
                        size: Size(74.w, 20.h),
                        margin: EdgeInsets.only(right: 5.w),
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                        style: AppStyle.text14.copyWith(color: AppColorLight.onPrimary),
                        text: _getPinProductText(context),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
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
