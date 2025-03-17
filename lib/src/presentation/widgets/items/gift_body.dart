part of '../widgets.dart';

class GiftBody extends StatelessWidget {
  final int typeId;
  final GiftType giftType;
  final void Function(Gift)? onSendGift;
  const GiftBody({
    super.key,
    required this.typeId,
    this.giftType = GiftType.post,
    this.onSendGift,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColorLight.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            gradient: LinearGradient(
              colors: AppCustomColor.gradientTitle,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.03, 0.21, 0.8, 1],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColorLight.surface, width: 0.5.w),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Image.asset(AppAsset.images.coin.path, width: 20.sp),
                    6.horizontalSpace,
                    BlocBuilder<GiftCubit, GiftState>(
                      builder: (context, state) {
                        return AppText(
                          state.giftList.userTotalCoin.shortCurrency,
                          style: AppStyle.text12.copyWith(color: AppColorLight.surface),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              AppText(
                context.text.sendGift,
                style: AppStyle.text16.copyWith(color: AppColorLight.surface),
              ),
              30.horizontalSpace,
              Spacer(),
              InkWell(
                onTap: () => DNavigator.back(),
                child: Icon(
                  FontAwesomeIcons.circleXmark,
                  size: 20.sp,
                  color: AppColorLight.surface,
                ),
              ),
            ],
          ),
        ),
        20.verticalSpace,
        Expanded(
          child: BlocBuilder<GiftCubit, GiftState>(
            builder: (context, state) {
              return GridView.builder(
                itemCount: state.giftList.gifts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  // mainAxisSpacing: 5.h,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return GridViewGiftItem(
                    gift: state.giftList.gifts[index],
                    typeId: typeId,
                    giftType: giftType,
                    onSendGift: onSendGift,
                  );
                },
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            children: [
              AppText(
                AppConfig.context!.text.sort,
                onTap: () => context.read<GiftCubit>().fetchGiftList(enableSort: true),
                style: AppStyle.text12.copyWith(color: AppCustomColor.orangeF4, fontWeight: FontWeight.w600),
              ),
              5.horizontalSpace,
              BlocBuilder<GiftCubit, GiftState>(
                builder: (context, state) {
                  return Icon(
                    state.sort ? Icons.keyboard_double_arrow_down_rounded : Icons.keyboard_double_arrow_up_rounded,
                    size: 20.sp,
                    color: AppCustomColor.orangeF4,
                  );
                },
              ),
              Spacer(),
              GradientButton(
                onPressed: _topUpCoin,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                text: AppConfig.context!.text.sendGift,
                customChild: Row(
                  children: [
                    Image.asset(AppAsset.images.coin.path, width: 20.sp),
                    10.horizontalSpace,
                    AppText(
                      AppConfig.context!.text.topUpCoin,
                      style: AppStyle.text12.copyWith(color: AppColorLight.surface),
                    ),
                  ],
                ),
                style: AppStyle.text12.copyWith(color: Colors.white),
                size: Size(116.w, 42.h),
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
              ),
            ],
          ),
        )
      ],
    );
  }

  void _topUpCoin() {
    DNavigator.back();
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: AddCoin(),
    );
  }
}
