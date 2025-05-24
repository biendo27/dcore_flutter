part of '../shop.dart';

class DefaultDeliveryAddressItem extends StatelessWidget {
  final UserBillingAddress addressData;
  final bool isHideEdit;
  const DefaultDeliveryAddressItem({
    super.key,
    required this.addressData,
    this.isHideEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    if (addressData.id == 0) {
      return Container(
        // padding: EdgeInsets.all(10.sp),
        // margin: EdgeInsets.only(bottom: 10.h),
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
        child: AppText(
          onTap: () async {
            context.read<DeliveryAddressCubit>().fetchNationList();
            await DNavigator.goNamed(RouteNamed.deliveryAddress);
            if (!context.mounted) return;
            context.read<OrderCubit>().updateOrderInfo();
          },
          context.text.addNewAddress,
          style: AppStyle.text16.copyWith(color: AppCustomColor.blue1F),
        ),
      );
    }

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
      // padding: EdgeInsets.symmetric(vertical: 5.h),
      // margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText(
                addressData.name,
                style: AppStyle.text14,
              ),
              11.horizontalSpace,
              if (!isHideEdit) ...[
                Spacer(),
                AppText(
                  onTap: () {
                    context.read<DeliveryAddressCubit>()
                      ..setAddressFromBilling(addressData)
                      ..fetchNationList();
                    DNavigator.goNamed(RouteNamed.deliveryAddress);
                  },
                  context.text.edit,
                  style: AppStyle.text12.copyWith(color: AppCustomColor.blue1F),
                ),
                4.horizontalSpace,
                Icon(Icons.keyboard_arrow_right, size: 20.w, color: AppColorLight.onSurface),
              ]
            ],
          ),
          11.verticalSpace,
          AppText(addressData.phone, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w300)),
          5.verticalSpace,
          AppText(
            '${addressData.ward.name}, ${addressData.district.name}, ${addressData.city.name}, ${addressData.national.name}',
            style: AppStyle.text12.copyWith(fontWeight: FontWeight.w300),
            maxLines: 5,
          ),
          AppText(
            addressData.detail,
            style: AppStyle.text12.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
