part of '../shop.dart';

class DeliveryAddressItem extends StatelessWidget {
  final UserBillingAddress addressData;

  const DeliveryAddressItem({
    super.key,
    required this.addressData,
  });

  Widget getAddressDefaultWidget(BuildContext context) {
    return addressData.isDefault == false
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppCustomColor.greyD9,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: AppText(
              context.text.defaultText,
              style: AppStyle.text10.copyWith(fontWeight: FontWeight.w300),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColorLight.onSurface.op(0.25), width: 0.5.w),
        borderRadius: BorderRadius.circular(5.r),
      ),
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
              getAddressDefaultWidget(context),
              Spacer(),
              GestureDetector(
                onTap: () {
                  context.read<DeliveryAddressCubit>()
                    ..setAddressFromBilling(addressData)
                    ..fetchNationList();
                  DNavigator.goNamed(RouteNamed.editAddress);
                },
                child: AppText(
                  context.text.edit,
                  style: AppStyle.text12.copyWith(color: AppCustomColor.blue1F),
                ),
              ),
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
