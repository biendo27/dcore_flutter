part of '../../shop.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: UserOrderStatusType.values.length, vsync: this);
    context.read<OrderListCubit>().fetchOrderList(isInit: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.order,
      isLoading: context.select((OrderListCubit cubit) => cubit.state.isLoading),
      onRefresh: () async => context.read<OrderListCubit>().fetchOrderList(isInit: true, type: UserOrderStatusType.values[tabController.index]),
      onLoadMore: () async => context.read<OrderListCubit>().fetchOrderList(type: UserOrderStatusType.values[tabController.index]),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBarSection(tabController: tabController),
            20.verticalSpace,
            BlocBuilder<OrderListCubit, OrderListState>(
              builder: (context, state) {
                return OrderItemList(orders: state.userOrders.data);
              },
            ),
            20.verticalSpace,
            OtherProducts(),
          ],
        ),
      ),
    );
  }
}
