part of '../shop.dart';

class ItemProductOrderSummary extends StatelessWidget {
  final Product product;
  const ItemProductOrderSummary({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DCachedImage(url: product.thumbnail, width: 68.w, height: 74.w),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  product.name,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                2.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            product.variantString,
                            style: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
                          ),
                          Row(
                            children: [
                              AppText(
                                product.price.currencyVND,
                                style: AppStyle.text10.copyWith(fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough, color: AppCustomColor.greyAC),
                              ),
                              4.horizontalSpace,
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                                decoration: BoxDecoration(
                                  color: AppCustomColor.redD0.op(0.1),
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: AppText(
                                  "-${product.discount}%",
                                  style: AppStyle.text10.copyWith(color: AppCustomColor.redD0),
                                ),
                              ),
                            ],
                          ),
                          AppText(
                            product.discountedPrice.currencyVND,
                            style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.redD0),
                          ),
                        ],
                      ),
                    ),
                    AppText(
                      'x${product.quantity}',
                      style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.greyAC),
                    ),
                    // IncreaseOrDecreaseQuantity(
                    //   quantityNotifier: ValueNotifier(number),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
