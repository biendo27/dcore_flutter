part of '../../shop.dart';

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({super.key});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.orderStatus,
      isLoading: context.select((OrderListCubit cubit) => cubit.state.isLoading),
      onRefresh: () async => context.read<OrderListCubit>().fetchOrderDetail(),
      body: BlocBuilder<OrderListCubit, OrderListState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      StatusInfo(status: state.currentOrder.status),
                      10.verticalSpace,
                      DefaultDeliveryAddressItem(addressData: state.currentOrder.billingAddress, isHideEdit: true),
                      OrdersFromSellerList(order: state.currentOrder),
                      10.verticalSpace,
                      DTitleAndText(
                        title: context.text.total,
                        text: context.text.quantityTotal(
                            state.currentOrder.totalQuantity, state.currentOrder.finalTotalOrderPrice.currencyVND),
                        margin: EdgeInsets.zero,
                        titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                        flexTitle: 1,
                      ),
                      16.verticalSpace,
                      OrderStatusInfo(userOrder: state.currentOrder),
                      OrderDetailInfo(userOrder: state.currentOrder),
                      24.verticalSpace,
                      OtherProducts(),
                    ],
                  ),
                ),
              ),
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: OrderStatusButton(
                  onTap: () => context.read<MessageCubit>().onChatStore(state.currentOrder.store.user2),
                  order: state.currentOrder,
                  orderStatus: state.currentOrder.status,
                ),
              ),
              10.verticalSpace,
            ],
          );
        },
      ),
    );
  }
}
