part of '../shop.dart';

class OrdersFromSellerChatList extends StatelessWidget {
  final UserOrder order;

  const OrdersFromSellerChatList({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        12.verticalSpace,
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              context.read<OrderListCubit>().fetchOrderList(isInit: true);
              context.read<ProductCubit>().initProductData(order.orderProducts[index].product);
              DNavigator.goNamed(RouteNamed.productDetail);
            },
            child: OrderFromSellerItem2(
              orderProduct: order.orderProducts[index],
              orderStatus: order.status,
              userOrder: order,
            ),
          ),
        ),
      ],
    );
  }
}
