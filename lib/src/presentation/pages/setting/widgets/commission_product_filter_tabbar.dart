part of '../setting.dart';

class CommissionProductFilterTabbar extends StatelessWidget {
  final TabController tabController;
  const CommissionProductFilterTabbar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: AppColorLight.onSurface,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColorLight.onSurface,
      unselectedLabelColor: AppColorLight.onSurface,
      labelStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w400, color: AppColorLight.onSurface),
      labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
      onTap: (index) => context.read<AffiliateCubit>().filterProductData(sortOption: SortOption.values[index]),
      tabs: [
        Tab(text: SortOption.related.displayValue(context)),
        Tab(text: SortOption.newest.displayValue(context)),
        Tab(text: SortOption.bestSelling.displayValue(context)),
        Tab(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(SortOption.price.displayValue(context), style: AppStyle.text14.copyWith(fontWeight: FontWeight.w400)),
              4.horizontalSpace,
              SvgPicture.asset(AppAsset.svg.expandAll, width: 16.w, height: 16.h),
            ],
          ),
        ),
      ],
    );
  }
}
