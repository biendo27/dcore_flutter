part of '../shop.dart';

class OrderDetailInfo extends StatelessWidget {
  final UserOrder userOrder;
  const OrderDetailInfo({
    super.key,
    required this.userOrder,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, size: 18.w),
            4.horizontalSpace,
            AppText(
              context.text.orderDetail,
              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        10.verticalSpace,
        DTitleAndText(
          title: context.text.orderCode,
          text: userOrder.code,
          titleStyle: AppStyle.text14,
          textStyle: AppStyle.text14,
          flexText: 5,
        ),
        10.verticalSpace,
        DTitleAndText(
          title: context.text.paymentMethod,
          text: userOrder.paymentMethod.name,
          titleStyle: AppStyle.text14,
          textStyle: AppStyle.text14,
          flexText: 4,
        ),
        if (userOrder.shipmentCode.isNotEmpty) ...[
          10.verticalSpace,
          DTitleAndText(
            title: context.text.shippingCode,
            text: userOrder.shipmentCode,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14,
            flexText: 5,
          ),
        ],
        10.verticalSpace,
        DTitleAndText(
          title: context.text.orderDate,
          text: userOrder.createdAt?.dateValueString ?? '',
          titleStyle: AppStyle.text14,
          textStyle: AppStyle.text14,
          flexText: 5,
        ),
        if (userOrder.paymentDate != null) ...[
          10.verticalSpace,
          DTitleAndText(
            title: context.text.paymentDate,
            text: userOrder.paymentDate!.dateMonthValueString,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14,
            flexText: 5,
          ),
        ],
        if (userOrder.shippingDate != null) ...[
          10.verticalSpace,
          DTitleAndText(
            title: context.text.deliveryDate,
            text: userOrder.shippingDate!.dateMonthValueString,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14,
            flexText: 5,
          ),
        ],
        if (userOrder.cancelDate != null) ...[
          10.verticalSpace,
          DTitleAndText(
            title: context.text.cancelDate,
            text: userOrder.cancelDate!.dateMonthValueString,
            titleStyle: AppStyle.text14,
            textStyle: AppStyle.text14,
            flexText: 5,
          ),
        ],
      ],
    );
  }
}
