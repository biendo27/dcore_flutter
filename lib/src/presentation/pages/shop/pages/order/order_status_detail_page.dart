part of '../../shop.dart';

class OrderStatusDetailPage extends StatelessWidget {
  const OrderStatusDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderListCubit, OrderListState>(
      builder: (context, state) {
        return SubLayout(
          title: context.text.orderStatus,
          isLoading: state.isLoading,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  '${context.text.deliveryBy}: J&T Express',
                  style: AppStyle.text16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                20.verticalSpace,
                Expanded(
                  child: ListView.builder(
                    itemCount: state.orderDeliveryStatuses.length,
                    itemBuilder: (context, index) => OrderStatusItem(
                      orderDeliveryStatus: state.orderDeliveryStatuses[index],
                      isFirst: index == 0,
                      isLast: index == state.orderDeliveryStatuses.length - 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
