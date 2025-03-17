part of '../shop.dart';

class OrderSummaryInfo extends StatelessWidget {
  final OrderOverviewInfo orderOverviewInfo;
  const OrderSummaryInfo({super.key, required this.orderOverviewInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r), // Bo góc
        border: Border.all(
          color: Colors.grey.shade300, // Màu viền
          width: 1, // Độ dày viền
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.op(0.05), // Đổ bóng nhẹ
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2), // Bóng đổ xuống dưới
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppAsset.svg.account, width: 14.w, height: 14.w),
              4.horizontalSpace,
              AppText(
                context.text.summary,
                style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          12.verticalSpace,
          DTitleAndText(
            title: context.text.totalProductPrice,
            text: orderOverviewInfo.totalPrice.currencyVND,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14,
            flexText: 5,
          ),
          10.verticalSpace,
          DTitleAndText(
            title: context.text.shippingFee,
            text: orderOverviewInfo.totalShippingFee.currencyVND,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14,
            flexText: 5,
          ),
          10.verticalSpace,
          DTitleAndText(
            title: context.text.discountShippingFee,
            text: orderOverviewInfo.totalShippingVoucher.currencyVND,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14,
            flexText: 5,
          ),
          10.verticalSpace,
          DTitleAndText(
            title: context.text.useVoucher,
            text: orderOverviewInfo.totalVoucher.currencyVND,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14,
            flexText: 5,
          ),
          if (orderOverviewInfo.isUseCoin) ...[
            10.verticalSpace,
            DTitleAndText(
              title: context.text.usePoints,
              text:
                  "${orderOverviewInfo.actualCoinsUsed} ${context.text.coin.toLowerCase()} (${orderOverviewInfo.changeCoinToMoney.currencyVND})",
              titleStyle: AppStyle.text14,
              textStyle: AppStyle.text14,
              flexText: 5,
            ),
          ],
          10.verticalSpace,
          DTitleAndText(
            title: "${context.text.totalPayment}:",
            text: orderOverviewInfo.totalMoney.currencyVND,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            flexText: 5,
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
