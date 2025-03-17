part of '../shop.dart';

class OrderStatusButton extends StatelessWidget {
  final UserOrder order;
  final OrderStatus orderStatus;
  final VoidCallback onTap;

  const OrderStatusButton({
    super.key,
    required this.order,
    required this.orderStatus,
    required this.onTap,
  });

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

  void secondaryButtonAction(BuildContext context) {
    if (order.status.code == UserOrderStatusType.success && order.isBuyAgain) {
      buyAgain(context);
      return;
    }

    if (order.status.code == UserOrderStatusType.success && order.isReturn) {
      context.read<OrderActionCubit>()
        ..setCurrentOrder(order)
        ..setActionImages([])
        ..getOrderReturnInfo()
        ..getOrderReturnCategories();
      DNavigator.goNamed(RouteNamed.refundOrder);
      return;
    }

    if (order.status.code == UserOrderStatusType.pending && order.isCancel) {
      context.read<OrderActionCubit>()
        ..setCurrentOrder(order)
        ..getOrderCancelInfo()
        ..getOrderCancelCategories();

      DNavigator.goNamed(RouteNamed.cancelOrder);
      return;
    }

    if (order.status.code == UserOrderStatusType.delivering && !order.isConfirm) {
      context.read<OrderActionCubit>()
        ..setCurrentOrder(order)
        ..receiveConfirm();
      return;
    }

    if ((order.status.code == UserOrderStatusType.delivering ||
            order.status.code == UserOrderStatusType.awaitingDelivery) &&
        order.isTracking) {
      context.read<OrderListCubit>().fetchOrderDeliveryStatuses(orderId: order.id);
      DNavigator.goNamed(RouteNamed.orderStatusDetail);
      return;
    }

    if (order.status.code == UserOrderStatusType.cancel && order.isBuyAgain) {
      buyAgain(context);
      return;
    }
  }

  String textButton(BuildContext context) {
    switch (orderStatus.code) {
      case UserOrderStatusType.all || UserOrderStatusType.pending || UserOrderStatusType.awaitingDelivery:
        return context.text.cancelOrder;
      case UserOrderStatusType.delivering:
        return context.text.confirmReceipt;
      case UserOrderStatusType.cancel:
        return context.text.buyAgain;
      case UserOrderStatusType.success:
        if (order.isBuyAgain) return context.text.buyAgain;
        if (order.isReturn) return context.text.returnOrder;
        return context.text.buyAgain;
    }
  }

  bool get isSecondaryButton {
    return orderStatus.code == UserOrderStatusType.all || orderStatus.code == UserOrderStatusType.pending;
  }

  bool get isDeliveryStatus {
    return orderStatus.code == UserOrderStatusType.awaitingDelivery;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return OrderItemAction(
              title: context.text.contact,
              onTap: onTap,
              expandFlex: 1,
            );
          },
        ),
        if (!isDeliveryStatus) ...[
          24.horizontalSpace,
          OrderItemAction(
            title: textButton(context),
            isSecondary: isSecondaryButton,
            expandFlex: 1,
            onTap: () => secondaryButtonAction(context),
          ),
        ],
      ],
    );
  }
}
