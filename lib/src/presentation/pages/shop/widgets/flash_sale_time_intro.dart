part of '../shop.dart';

class FlashSaleTimeIntro extends StatelessWidget {
  const FlashSaleTimeIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          AppText(
            "Flash Sale",
            style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
          ),
          Spacer(),
          AppText(
            context.text.timeLeft.toUpperCase(),
            style: AppStyle.text12,
          ),
          10.horizontalSpace,
          BlocBuilder<FlashSaleCubit, FlashSaleState>(
            builder: (context, state) {
              return FlashSaleCountdown(initialDuration: Duration(seconds: state.currentFlashSale.endTime?.diffTimeInSeconds(DateTime.now()) ?? 0));
            },
          ),
        ],
      ),
    );
  }
}
