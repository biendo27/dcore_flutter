part of '../shop.dart';

class OrderSummaryVoucherAndCoinInfo extends StatelessWidget {
  final OrderOverviewInfo orderOverviewInfo;
  final ValueNotifier<bool> isUseCoin;
  final ValueNotifier<Voucher> selectedShippingVoucher;
  final ValueNotifier<Voucher> selectedOtherVoucher;
  final ValueNotifier<bool> noUseVoucherCode;
  const OrderSummaryVoucherAndCoinInfo({
    super.key,
    required this.orderOverviewInfo,
    required this.isUseCoin,
    required this.selectedShippingVoucher,
    required this.selectedOtherVoucher,
    required this.noUseVoucherCode,
  });

  void viewDiscountFromVnsshopBody(BuildContext context) {
    context.read<OrderCubit>()
      ..getOrderVouchers(isInit: true)
      ..getOrderShippingVouchers(isInit: true);
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      isScrollControlled: true,
      bodyWidget: DiscountFromVnsShopBody(
        title: context.text.discountFromVnsLive,
        selectedShippingVoucher: selectedShippingVoucher,
        selectedOtherVoucher: selectedOtherVoucher,
        noUseVoucherCode: noUseVoucherCode,
      ),
    );
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          25.verticalSpace,
          InkWell(
            onTap: () => viewDiscountFromVnsshopBody(context),
            child: Row(
              children: [
                SvgPicture.asset(AppAsset.svg.discountPercentCoupon, width: 14.w, height: 14.w),
                4.horizontalSpace,
                AppText(
                  context.text.discountFromVnsLive,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                AppText(
                  orderOverviewInfo.vouchers.isNotEmpty ? "${context.text.selected} ${orderOverviewInfo.vouchers.length}" : context.text.unselected,
                  style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.blue1F),
                ),
                4.horizontalSpace,
                Icon(Icons.keyboard_arrow_right, size: 20.w, color: AppColorLight.onSurface),
              ],
            ),
          ),
          12.verticalSpace,
          ...List.generate(
            orderOverviewInfo.vouchers.length,
            (index) => AppText(
              orderOverviewInfo.vouchers[index].name,
              style: AppStyle.text14.copyWith(color: AppCustomColor.blue1F),
            ),
          ),
          Row(
            children: [
              Image.asset(AppAsset.images.coin.path, width: 15.w, height: 15.w),
              4.horizontalSpace,
              AppText(
                context.text.payByCoin,
                style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              AppText("${orderOverviewInfo.coin} ${context.text.coin.toLowerCase()}", style: AppStyle.text14),
              4.horizontalSpace,
              ValueListenableBuilder(
                  valueListenable: isUseCoin,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isUseCoin.value,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) {
                          isUseCoin.value = value;
                          context.read<OrderCubit>()
                            ..setIsUseCoin(value)
                            ..updateOrderInfo();
                        },
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
