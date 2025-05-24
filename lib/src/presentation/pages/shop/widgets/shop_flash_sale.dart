part of '../shop.dart';

class ShopFlashSale extends StatelessWidget {
  final CountDownController countDownController;
  const ShopFlashSale({super.key, required this.countDownController});

  @override
  Widget build(BuildContext context) {
    StoreHomeState storeState = context.watch<StoreHomeCubit>().state;
    LiveState liveState = context.watch<LiveCubit>().state;
    if (storeState.storeHome.flashSale.products.isEmpty && liveState.liveList.data.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (storeState.storeHome.flashSale.products.isNotEmpty) ...[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.verticalSpace,
                ShopTitleItem(
                  title: "Flash Sale",
                  isViewAll: false,
                  prefix: Container(
                    margin: EdgeInsets.only(right: 9.w),
                    height: 15.h,
                    width: 4.w,
                    decoration: BoxDecoration(
                      color: AppCustomColor.orangeF1,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  bonus: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppCustomColor.orangeF1,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: CountdownTimerWidget(
                      countdownController: countDownController,
                      style: AppStyle.text10.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    context.read<FlashSaleCubit>().fetchFlashSale();
                    DNavigator.goNamed(RouteNamed.flashSale);
                  },
                ),
                4.verticalSpace,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 20.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: storeState.storeHome.flashSale.products.map((e) => FlashSalesItem(product: e)).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          15.horizontalSpace,
        ],
        if (liveState.liveList.data.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                14.verticalSpace,
                ShopTitleItem(
                  title: "Live Shopping",
                  padding: EdgeInsets.only(left: 20.w),
                  isViewAll: false,
                  prefix: Container(
                    margin: EdgeInsets.only(right: 9.w),
                    height: 15.h,
                    width: 4.w,
                    decoration: BoxDecoration(
                      color: AppCustomColor.orangeF1,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  onTap: () {
                    context.read<FlashSaleCubit>().fetchFlashSale();
                    DNavigator.goNamed(RouteNamed.flashSale);
                  },
                ),
                4.verticalSpace,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w, left: 20.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: liveState.liveList.data.map((e) => LiveShoppingItem(liveData: e)).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
