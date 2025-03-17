part of '../home.dart';

class TopUpBody extends StatelessWidget {
  const TopUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.65 - MediaQuery.viewInsetsOf(context).bottom,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        gradient: LinearGradient(
          colors: AppCustomColor.background2Color,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,  
          stops: [0.03, 0.2],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56.h,
            alignment: Alignment.center,
            child: AppText(
              context.text.firstDepositOffer,
              style: AppStyle.text18.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 111.h,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: AppColorLight.surface,
              border: Border.all(
                color: AppCustomColor.orangeF5,
                width: 0.1.w,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 65.w,
                  height: 75.w,
                  child: Stack(children: [
                    Image.asset(AppAsset.images.coin.path, width: 50.w),
                    Positioned(
                      left: 15.w,
                      top: 20.h,
                      child: Image.asset(AppAsset.images.coin.path, width: 50.w),
                    ),
                  ]),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DHighlightText(
                        text: context.text.receiveExtraCoin,
                        style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600),
                        highlights: ["Extra Coin", "Xu thưởng"],
                        highlightStyles: [
                          AppStyle.text14.copyWith(fontWeight: FontWeight.w600, color: AppCustomColor.orangeF1),
                          AppStyle.text14.copyWith(fontWeight: FontWeight.w600, color: AppCustomColor.orangeF1),
                        ],
                      ),
                      10.verticalSpace,
                      AppText(
                        context.text.useCoinToBuy,
                        style: AppStyle.text12,
                        maxLines: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          10.verticalSpace,
          DHighlightText(
            text: context.text.receiveCoin,
            style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600),
            highlights: ["Coin", "Xu"],
            highlightStyles: [
              AppStyle.text14.copyWith(fontWeight: FontWeight.w600, color: AppCustomColor.orangeF1),
              AppStyle.text14.copyWith(fontWeight: FontWeight.w600, color: AppCustomColor.orangeF1),
            ],
          ),
          10.verticalSpace,
          Expanded(
            child: GridView.builder(
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 12.h,
              ),
              itemBuilder: (context, index) {
                return ItemTopUp();
              },
            ),
          ),
          20.verticalSpace,
          InkWell(
            onTap: () {
              _viewVirtualItemPolicy();
            },
            child: DHighlightText(
              text: context.text.agreeWithVirtualItemPolicy,
              style: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
              highlights: ["virtual item policy", "chính sách vật phẩm ảo"],
              highlightStyles: [
                AppStyle.text14.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                AppStyle.text14.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
              ],
            ),
          ),
          10.verticalSpace,
          GradientButton(
            onPressed: () {},
            text: context.text.buy,
            style: AppStyle.text14.copyWith(color: Colors.white),
            customChild: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(context.text.buy, style: AppStyle.text14.copyWith(color: Colors.white)),
                4.horizontalSpace,
                Image.asset(AppAsset.images.coin.path, width: 15.sp),
                4.horizontalSpace,
                AppText(
                  context.text.coinPrice(32, 6000.currencyVND),
                  style: AppStyle.text14.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _viewVirtualItemPolicy() {
    showDModalBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: VirtualItemPolicyBody(),
    );
  }
}
