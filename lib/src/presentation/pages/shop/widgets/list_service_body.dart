part of '../shop.dart';

class ListServiceBody extends StatelessWidget {
  const ListServiceBody({
    super.key,
  });

  void showCancelOrder(BuildContext context) {
    DNavigator.back();
    String term = context.read<ProductCubit>().state.productCancelOrderTutorialTerm;
    showDataBottomSheet(
      maxChildSize: 0.5,
      initialChildSize: 0.5,
      title: context.text.orderCancellationGuide,
      body: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          child: HtmlWidget(
            term,
            textStyle: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75 - MediaQuery.viewInsetsOf(context).bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                20.horizontalSpace,
                AppText(
                  context.text.service,
                  expandFlex: 1,
                  style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () => DNavigator.back(),
                  child: Icon(
                    FontAwesomeIcons.circleXmark,
                    size: 20.sp,
                    color: AppColorLight.onSurface,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DIconText(
                    icon: Image.asset(AppAsset.icons.creditCard.path, width: 20.sp, height: 20.sp),
                    text: context.text.easyPayment,
                    textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                  ),
                  HtmlWidget(
                    context.select((ProductCubit bloc) => bloc.state.productService.easyPayment),
                    textStyle: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
                  ),
                  10.verticalSpace,
                  DIconText(
                    icon: Image.asset(AppAsset.icons.folderExclamation.path, width: 20.sp, height: 20.sp),
                    text: context.text.easyOrderCancellation,
                    textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                  ),
                  HtmlWidget(
                    context.select((ProductCubit bloc) => bloc.state.productService.cancelOrdersEasily),
                    textStyle: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
                  ),
                  AppText(
                    context.text.learnMore,
                    style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.blue1F),
                    onTap: () => showCancelOrder(context),
                  ),
                  10.verticalSpace,
                  DIconText(
                    icon: Image.asset(AppAsset.icons.message.path, width: 20.sp, height: 20.sp),
                    text: context.text.supportTeam,
                    textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                  ),
                  HtmlWidget(
                    context.select((ProductCubit bloc) => bloc.state.productService.supportTeam),
                    textStyle: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
