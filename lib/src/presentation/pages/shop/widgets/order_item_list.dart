part of '../shop.dart';

class OrderItemList extends StatelessWidget {
  final List<UserOrder> orders;
  const OrderItemList({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return NoData(message: context.text.noOrderData);
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => OrderItem(order: orders[index]),
      itemCount: orders.length,
    );
  }
}
