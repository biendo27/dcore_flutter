part of '../shop.dart';

class StatusInfo extends StatelessWidget {
  final OrderStatus status;

  const StatusInfo({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<OrderListCubit>().fetchOrderDeliveryStatuses();
        DNavigator.goNamed(RouteNamed.orderStatusDetail);
      },
      child: Container(
        decoration: BoxDecoration(
          color: status.code.statusColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.all(8.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  context.text.shippingStatus,
                  style: AppStyle.text12.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColorLight.surface,
                  ),
                ),
                2.verticalSpace,
                AppText(
                  "${context.text.order} ${status.code.displayName(context).toLowerCase()}",
                  style: AppStyle.text10.copyWith(
                    // fontWeight: FontWeight.w300,
                    color: AppColorLight.surface,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppColorLight.surface,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
