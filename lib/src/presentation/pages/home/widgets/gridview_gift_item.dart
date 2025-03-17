part of '../home.dart';

class GridViewGiftItem extends StatelessWidget {
  final Gift gift;
  final int typeId;
  final GiftType giftType;
  final void Function(Gift)? onSendGift;
  const GridViewGiftItem({
    super.key,
    required this.gift,
    required this.typeId,
    this.giftType = GiftType.post,
    this.onSendGift,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColorLight.onSurface.op(0.25)),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DCachedImage(
                url: gift.image,
                height: 72.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppCustomColor.orangeF4.op(0.1),
                ),
                child: AppText(
                  '${gift.coin.shortCurrency} Coins',
                  style: AppStyle.textBold10.copyWith(color: AppCustomColor.orangeF5),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            context.read<GiftCubit>().giveGift(
                  gift: gift,
                  giftType: giftType,
                  typeId: typeId,
                  onSendGift: onSendGift,
                );
            DNavigator.back();
          },
          child: Container(
            height: 30.h,
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppCustomColor.gradientButton,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0, 0.4, 0.65, 0.73, 1],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
            ),
            child: AppText(
              context.text.send,
              style: AppStyle.text12.copyWith(color: AppColorLight.surface),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
