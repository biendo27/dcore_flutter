part of '../shop.dart';


class OrderStatusItem extends StatelessWidget {
  final OrderDeliveryStatus orderDeliveryStatus;
  final bool isLast;
  final bool isFirst;

  const OrderStatusItem({
    super.key,
    required this.orderDeliveryStatus,
    this.isLast = false,
    this.isFirst = false,
  });

  bool get isCompleted => orderDeliveryStatus.status == 'Picked Up';

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: isCompleted ? 20.w : 10.w,
                height: isCompleted ? 20.w : 10.w,
                margin: EdgeInsets.symmetric(horizontal: isCompleted ? 0 : 5.w),
                decoration: BoxDecoration(
                  color: isCompleted ? AppCustomColor.green05 : AppCustomColor.greyC4,
                  shape: BoxShape.circle,
                ),
                child: isCompleted
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14.sp,
                      )
                    : SizedBox.shrink(),
              ),
              Expanded(
                child: Container(
                  width: 1,
                  color: AppCustomColor.greyC4,
                ),
              ),
            ],
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  orderDeliveryStatus.createdAt?.dateTimeString ?? '',
                  style: AppStyle.text14.copyWith(
                    color: Colors.grey,
                  ),
                ),
                AppText(
                  orderDeliveryStatus.status,
                  style: AppStyle.text16.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? AppCustomColor.green05 : AppThemeMaterial.lightColorScheme.shadow,
                  ),
                ),
                4.verticalSpace,
                AppText(
                  orderDeliveryStatus.description,
                  style: AppStyle.text14.copyWith(
                    color: AppThemeMaterial.lightColorScheme.shadow,
                  ),
                ),
                if (!isLast) 16.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
