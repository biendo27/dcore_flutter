part of '../shop.dart';

class OrderItem extends StatelessWidget {
  final UserOrder order;
  final bool isReturnable;
  final void Function()? onTap;
  const OrderItem({
    super.key,
    required this.order,
    this.isReturnable = false,
    this.onTap,
  });

  void sendEvaluate(BuildContext context) {
    context.read<OrderActionCubit>().setActionImages([]);

    showDModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      bodyWidget: EvaluateBody(orderProductIds: order.orderProducts.map((e) => e.id).toList()),
    );
  }

  void buyAgain(BuildContext context) {
    if (order.orderProducts.isEmpty) {
      return;
    }

    UserBillingAddress defaultAddress = context.read<DeliveryAddressCubit>().state.defaultAddress;
    PaymentMethod paymentMethod = context.read<OrderPaymentMethodCubit>().state.paymentMethods.first;
    List<Product> products = order.orderProducts.map((e) => e.productInfo).toList();

    OrderOverviewInfo orderOverviewInfo = OrderOverviewInfo(
      paymentMethods: paymentMethod,
      billingAddress: defaultAddress,
      stores: products.orderOverviewStoreInfos,
    );

    context.read<OrderCubit>()
      ..setOrderOverviewInfo(orderOverviewInfo)
      ..updateOrderInfo();

    DNavigator.goNamed(RouteNamed.orderSummary);
  }

  Widget actionButton(BuildContext context) {
    if (order.status.code == UserOrderStatusType.success && order.isReview && order.isBuyAgain) {
      return Row(
        children: [
          OrderItemAction(
            onTap: () => buyAgain(context),
            title: context.text.buyAgain,
            expandFlex: 1,
          ),
          10.horizontalSpace,
          OrderItemAction(
            onTap: () => sendEvaluate(context),
            title: context.text.evaluate,
            expandFlex: 1,
          ),
        ],
      );
    }

    if (order.status.code == UserOrderStatusType.success && order.isReview && order.isReturn) {
      return Row(
        children: [
          OrderItemAction(
            onTap: () {
              context.read<OrderActionCubit>()
                ..setCurrentOrder(order)
                ..setActionImages([])
                ..getOrderReturnInfo()
                ..getOrderReturnCategories();
              DNavigator.goNamed(RouteNamed.refundOrder);
            },
            title: context.text.returnOrder,
            expandFlex: 1,
          ),
          10.horizontalSpace,
          OrderItemAction(
            onTap: () => sendEvaluate(context),
            title: context.text.evaluate,
            expandFlex: 1,
          ),
        ],
      );
    }

    if (order.status.code == UserOrderStatusType.success && order.isBuyAgain) {
      return OrderItemAction(
        onTap: () => buyAgain(context),
        title: context.text.buyAgain,
      );
    }

    if (order.status.code == UserOrderStatusType.pending && order.isCancel) {
      return OrderItemAction(
        onTap: () {
          context.read<OrderActionCubit>()
            ..setCurrentOrder(order)
            ..getOrderCancelInfo()
            ..getOrderCancelCategories();

          DNavigator.goNamed(RouteNamed.cancelOrder);
        },
        title: context.text.cancelOrder,
      );
    }

    if (order.status.code == UserOrderStatusType.cancel && order.isBuyAgain) {
      return OrderItemAction(
        onTap: () => buyAgain(context),
        title: context.text.buyAgain,
      );
    }

    if (order.status.code == UserOrderStatusType.delivering && order.isTracking) {
      return OrderItemAction(
        onTap: () {
          context.read<OrderListCubit>().fetchOrderDeliveryStatuses(orderId: order.id);
          DNavigator.goNamed(RouteNamed.orderStatusDetail);
        },
        title: context.text.followOrder,
      );
    }

    if (order.status.code == UserOrderStatusType.awaitingDelivery && order.isTracking) {
      return OrderItemAction(
        onTap: () {
          context.read<OrderListCubit>().fetchOrderDeliveryStatuses(orderId: order.id);
          DNavigator.goNamed(RouteNamed.orderStatusDetail);
        },
        title: context.text.followOrder,
      );
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    Widget tmp = InkWell(
      onTap: () {
        context.read<OrderListCubit>()
          ..setCurrentOrder(order)
          ..fetchOrderDetail();
        DNavigator.goNamed(RouteNamed.orderStatus);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: AppCustomColor.greyAC, width: 0.2.w),
        ),
        margin: EdgeInsets.only(bottom: 13.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(2.sp),
                  decoration: BoxDecoration(
                    color: AppCustomColor.orangeF4.op(0.1),
                    borderRadius: BorderRadius.circular(3.sp),
                  ),
                  child: AppText(
                    context.text.fromVnsShop,
                    style: AppStyle.text10.copyWith(color: AppCustomColor.orangeF1),
                  ),
                ),
                AppText(
                  order.status.code.displayName(context),
                  style: AppStyle.text12.copyWith(color: AppCustomColor.redF5),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    color: AppCustomColor.greyD9,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: DCachedImage(
                    url: order.orderProducts.first.product.thumbnail,
                    width: 65.w,
                    height: 65.w,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        order.orderProducts.first.product.name,
                        style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.onSurface),
                      ),
                      2.verticalSpace,
                      AppText(
                        parse(order.orderProducts.first.product.description).documentElement?.text ?? "",
                        style: AppStyle.text12.copyWith(
                          color: AppColorLight.onSurface.op(0.4),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      2.verticalSpace,
                      AppText(
                        '${context.text.quantity}: ${order.orderProducts.first.quantity}',
                        style: AppStyle.text12.copyWith(color: AppColorLight.onSurface.op(0.4)),
                      ),
                      10.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppText(
                            order.totalOrderPrice.currencyVND,
                            style: AppStyle.text12,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                AppText(
                  '${order.orderProducts.length} ${context.text.product.toLowerCase()}',
                  style: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
                ),
                Spacer(),
                AppText(
                  context.text.totalPayment,
                  style: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
                ),
                4.horizontalSpace,
                AppText(
                  order.finalTotalOrderPrice.currencyVND,
                  style: AppStyle.text12.copyWith(color: AppCustomColor.redD0),
                ),
              ],
            ),
            8.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  context.text.orderCode,
                  style: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
                ),
                AppText(
                  order.code,
                  style: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
                ),
              ],
            ),
            10.verticalSpace,
            actionButton(context),
          ],
        ),
      ),
    );

    if (onTap != null) {
      tmp = InkWell(
        onTap: onTap,
        child: tmp,
      );
    }

    return tmp;
  }
}
