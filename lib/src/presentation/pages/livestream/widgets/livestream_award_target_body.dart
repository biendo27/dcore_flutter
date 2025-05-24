part of '../livestream.dart';

class AwardTargetBody extends StatelessWidget {
  const AwardTargetBody({super.key});

  String giftText(BuildContext context, Live live) {
    return switch (live.typeGift) {
      LiveGiftType.coin => '${live.coinGift} ${context.text.coin}',
      LiveGiftType.voucher => live.voucherGift.name,
      LiveGiftType.product => live.productGift.name,
      LiveGiftType.wheel => '${live.wheelGift} ${context.text.spinWheel}',
    };
  }

  Widget decorationItem(BuildContext context, Live live) {
    return switch (live.typeGift) {
      LiveGiftType.coin => AppAsset.images.coin.image(
          width: 75.sp,
          height: 75.sp,
        ),
      LiveGiftType.voucher => DCachedImage(
          url: live.voucherGift.image,
          width: 75.sp,
          height: 75.sp,
        ),
      LiveGiftType.product => DCachedImage(
          url: live.productGift.thumbnail,
          width: 75.sp,
          height: 75.sp,
        ),
      LiveGiftType.wheel => AppAsset.images.spin.image(
          width: 75.sp,
          height: 75.sp,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.35.sh,
      child: Column(
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(36.r)),
            ),
            child: Row(
              children: [
                20.horizontalSpace,
                AppText(
                  context.text.award,
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
            child: Container(
              // background: linear-gradient(243.53deg, #FF1575 -16.16%, rgba(245, 137, 33, 0.8) 89.32%);
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppCustomColor.pinkFF,
                    AppCustomColor.orangeF5.op(0.8),
                  ],
                  stops: [-0.1616, 0.8932],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 16.sp),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: AppText(
                      context.text.chanceToReceiveGift(giftText(context, context.select((LiveCubit bloc) => bloc.state.currentLive))),
                      style: AppStyle.text22.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                      maxLines: 10,
                    ),
                  ),
                  20.horizontalSpace,
                  Expanded(
                    flex: 1,
                    child: decorationItem(context, context.select((LiveCubit bloc) => bloc.state.currentLive)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
