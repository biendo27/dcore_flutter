part of '../profile.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  const PersistentTabBar({required this.tabController});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
      controller: tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: GradientTabIndicator(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp)),
        gradient: LinearGradient(
          colors: AppCustomColor.gradientContainer,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        indicatorHeight: 3,
      ),
      tabs: TabItemType.values.map((e) => TabItem(type: e, isActive: true)).toList(),
    );
  }

  @override
  double get maxExtent => 62.h;

  @override
  double get minExtent => 62.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
