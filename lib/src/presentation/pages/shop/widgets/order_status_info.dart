part of '../shop.dart';

class OrderStatusInfo extends StatelessWidget {
  final UserOrder userOrder;
  const OrderStatusInfo({super.key, required this.userOrder});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          text: userOrder.totalOrderPrice.currencyVND,
          titleStyle: AppStyle.text14,
          textStyle: AppStyle.text14,
          flexText: 5,
        ),
        10.verticalSpace,
        DTitleAndText(
          title: context.text.shippingFee,
          text: userOrder.finalShippingFee.currencyVND,
          titleStyle: AppStyle.text14,
          textStyle: AppStyle.text14,
          flexText: 5,
        ),
        10.verticalSpace,
        DTitleAndText(
          title: context.text.discountShippingFee,
          text: userOrder.shippingDiscount.currencyVND,
          titleStyle: AppStyle.text14,
          textStyle: AppStyle.text14,
          flexText: 5,
        ),
        10.verticalSpace,
        DTitleAndText(
          title: context.text.useVoucher,
          text: userOrder.priceDiscount.currencyVND,
          titleStyle: AppStyle.text14,
          textStyle: AppStyle.text14,
          flexText: 5,
        ),
        10.verticalSpace,
        DTitleAndText(
          title: "${context.text.totalPayment}:",
          text: userOrder.finalTotalOrderPrice.currencyVND,
          titleStyle: AppStyle.text14,
          textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
          flexText: 5,
        ),
        20.verticalSpace,
      ],
    );
  }
}