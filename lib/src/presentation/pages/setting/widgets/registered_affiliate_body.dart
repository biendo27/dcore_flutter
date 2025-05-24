part of '../setting.dart';

class RegisteredAffiliateBody extends StatelessWidget {
  final ScrollController scrollController;
  const RegisteredAffiliateBody({super.key, required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AffiliateCubit, AffiliateState>(builder: (context, state) {
      return SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            InkWell(
              onTap: () => DNavigator.goNamed(RouteNamed.affiliateRegister),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
                decoration: BoxDecoration(
                  color: AppCustomColor.greyDA.op(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppCustomColor.greyDA.op(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      context.text.updateInformation,
                      style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 12.sp),
                  ],
                ),
              ),
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100.h,
                    width: 300.w,
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: AppColorLight.surface,
                      boxShadow: [
                        BoxShadow(
                          color: AppColorLight.onSurface.op(0.1),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(state.totalOrder.toString(), style: AppStyle.text30),
                        8.verticalSpace,
                        AppText(
                          context.text.orderPlaced,
                          style: AppStyle.text14.copyWith(color: AppCustomColor.grey50),
                        ),
                      ],
                    ),
                  ),
                ),
                20.horizontalSpace,
                Expanded(
                  child: Container(
                    height: 100.h,
                    width: 300.w,
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: AppColorLight.surface,
                      boxShadow: [
                        BoxShadow(
                          color: AppColorLight.onSurface.op(0.1),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(state.totalOrderSuccess.toString(), style: AppStyle.text30),
                        8.verticalSpace,
                        AppText(
                          context.text.orderSuccess,
                          style: AppStyle.text14.copyWith(color: AppCustomColor.grey50),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppCustomColor.greyE9,
                borderRadius: BorderRadius.circular(10.r),
                gradient: LinearGradient(
                  begin: Alignment(-1.0, -1.0),
                  end: Alignment(1.0, 1.0),
                  colors: AppCustomColor.gradientContainer,
                  stops: [0.0, 0.2248, 0.7857, 1.0],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        context.text.commission,
                        style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                      ),
                      8.verticalSpace,
                      AppText(state.totalCommission.currencyVND, style: AppStyle.text32.copyWith(fontWeight: FontWeight.w600, color: AppColorLight.surface)),
                    ],
                  ),
                  DButton(
                    size: Size(110.w, 32.h),
                    onPressed: () async {
                      await DNavigator.goNamed(RouteNamed.commission);
                      if (!context.mounted) return;
                      context.read<AffiliateCubit>().affiliateHome(1);
                    },
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    backgroundColor: AppColorLight.surface,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    customChild: Row(
                      children: [
                        AppText(context.text.withdrawToWallet, style: AppStyle.text14.copyWith(color: AppCustomColor.orangeF5)),
                        8.horizontalSpace,
                        Icon(Icons.keyboard_double_arrow_right_rounded, size: 18.sp, color: AppCustomColor.orangeF5),
                      ],
                    ),
                  )
                ],
              ),
            ),
            16.verticalSpace,
            AppText(
              context.text.listProduct,
              style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500),
            ),
            ListView.builder(
              itemCount: state.productSaves.length,
              padding: EdgeInsets.only(top: 10.h),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final product = state.productSaves[index];
                return ListAffiliateProductItem(isCopied: true, product: product.product);
              },
            ),
          ],
        ),
      );
    });
  }
}
