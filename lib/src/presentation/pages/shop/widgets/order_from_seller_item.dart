part of '../shop.dart';

class OrderFromSellerItem extends StatelessWidget {
  final OrderProduct orderProduct;
  final OrderStatus orderStatus;
  const OrderFromSellerItem({super.key, required this.orderProduct, required this.orderStatus});

  bool get showReview => orderStatus.code == UserOrderStatusType.success;

  void sendEvaluate(BuildContext context) {
    if (orderProduct.reviewed) {
      context.read<ReviewCubit>()
        ..setProduct(orderProduct.product)
        ..getProductReview();
      DNavigator.goNamed(RouteNamed.productReview);
      return;
    }
    context.read<OrderActionCubit>().setActionImages([]);

    showDModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      bodyWidget: EvaluateBody(orderProductIds: [orderProduct.id]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          DCachedImage(
            url: orderProduct.product.thumbnail,
            width: 70.w,
            height: 70.h,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.r),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      orderProduct.product.name,
                      maxLines: 1,
                      expandFlex: 1,
                      style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                    ),
                    if (showReview) ...[
                      20.horizontalSpace,
                      InkWell(
                        onTap: () => sendEvaluate(context),
                        child: AppText(
                          orderProduct.reviewed ? context.text.reviewed : context.text.notReviewed,
                          style: AppStyle.text12.copyWith(color: AppCustomColor.redF5, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ],
                ),
                12.verticalSpace,
                AppText(orderProduct.variantString, style: AppStyle.text10.copyWith(color: AppColorLight.onSurface)),
                4.verticalSpace,
                Row(
                  children: [
                    AppText(orderProduct.price.currencyVND,
                        style: AppStyle.text12.copyWith(color: AppCustomColor.redD0)),
                    6.horizontalSpace,
                    AppText('x${orderProduct.quantity}',
                        style: AppStyle.text12.copyWith(color: AppColorLight.onSurface)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderFromSellerItem2 extends StatelessWidget {
  final OrderProduct orderProduct;
  final OrderStatus orderStatus;
  final UserOrder userOrder;
  const OrderFromSellerItem2(
      {super.key, required this.orderProduct, required this.orderStatus, required this.userOrder});

  bool get showReview => orderStatus.code == UserOrderStatusType.success;

  void sendEvaluate(BuildContext context) {
    if (orderProduct.reviewed) {
      context.read<ReviewCubit>()
        ..setProduct(orderProduct.product)
        ..getProductReview();
      DNavigator.goNamed(RouteNamed.productReview);
      return;
    }
    context.read<OrderActionCubit>().setActionImages([]);

    showDModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      bodyWidget: EvaluateBody(orderProductIds: [orderProduct.id]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorLight.onPrimary,
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
      child: Row(
        children: [
          DCachedImage(
            url: orderProduct.product.thumbnail,
            width: 40.w,
            height: 40.h,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.r),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      "${context.text.orderCode}: ${userOrder.code}",
                      maxLines: 1,
                      expandFlex: 1,
                      style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
                    ),
                    if (showReview) ...[
                      5.horizontalSpace,
                      InkWell(
                        onTap: () => sendEvaluate(context),
                        child: AppText(
                          orderProduct.reviewed ? context.text.reviewed : context.text.notReviewed,
                          style: AppStyle.text12.copyWith(color: AppCustomColor.redF5, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ],
                ),
                4.verticalSpace,
                Row(
                  children: [
                    AppText("${context.text.totalAll}: ${orderProduct.totalMoney.currencyVND}",
                        style: AppStyle.textBold12.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
                4.verticalSpace,
                AppText(orderStatus.code.displayName(context).toLowerCase(),
                    style: AppStyle.textBold14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.redF5)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
