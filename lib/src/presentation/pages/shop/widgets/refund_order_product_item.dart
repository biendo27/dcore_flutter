part of '../shop.dart';

class RefundOrderProductItem extends StatelessWidget {
  final int shopId;
  final OrderProduct orderProduct;

  const RefundOrderProductItem({
    super.key,
    this.shopId = 0,
    required this.orderProduct,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DCachedImage(url: orderProduct.product.thumbnail, width: 68.w, height: 74.w),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  orderProduct.product.name,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                12.verticalSpace,
                AppText(orderProduct.variantString, style: AppStyle.text12.copyWith(color: AppColorLight.onSurface)),
                4.verticalSpace,
                Row(
                  children: [
                    AppText(orderProduct.price.currencyVND, style: AppStyle.text13.copyWith(color: AppCustomColor.redD0)),
                    6.horizontalSpace,
                    AppText('x${orderProduct.quantity}', style: AppStyle.text13.copyWith(color: AppColorLight.onSurface)),
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
