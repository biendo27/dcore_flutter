part of '../shop.dart';

class TabBarSection extends StatelessWidget {
  final TabController tabController;
  const TabBarSection({super.key, required this.tabController});
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      padding: EdgeInsets.zero,
      tabAlignment: TabAlignment.start,
      labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
      labelStyle: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppColorLight.onSurface,
      onTap: (index) => context.read<OrderListCubit>().fetchOrderList(isInit: true, type: UserOrderStatusType.values[index]),
      tabs: UserOrderStatusType.values.map((e) => Tab(text: e.displayName(context))).toList(),
    );
  }
}
