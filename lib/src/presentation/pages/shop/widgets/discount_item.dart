part of '../shop.dart';

class DiscountItem extends StatelessWidget {
  final Voucher voucher;
  final ValueNotifier<Voucher> selectedVoucherNotifier;
  final void Function(Voucher?)? onChanged;
  const DiscountItem({
    super.key,
    required this.voucher,
    required this.selectedVoucherNotifier,
    this.onChanged,
  });

  String get discountValueString => voucher.discountType == DiscountType.directly ? voucher.discountValue.shortCurrency : "${voucher.discountValue.formattedDecimal}%";

  void _showVoucherPolicy(BuildContext context) {
    context.read<LiveCubit>().fetchVoucherUsageTerms(voucher.id);
    showDataBottomSheet(
      title: context.text.termsAndConditions,
      bodyWidget: VoucherTermBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.sp),
        border: Border.all(color: AppCustomColor.orangeF5, width: 0.2.w),
      ),
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.only(bottom: 10.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.sp),
                decoration: BoxDecoration(
                  color: AppCustomColor.orangeF4.op(0.1),
                  borderRadius: BorderRadius.circular(3.sp),
                ),
                child: AppText(
                  voucher.from.name,
                  style: AppStyle.text8.copyWith(color: AppCustomColor.orangeF1),
                ),
              ),
              4.horizontalSpace,
              if (voucher.discountCondition > 0)
                Container(
                  padding: EdgeInsets.all(2.sp),
                  decoration: BoxDecoration(
                    color: AppCustomColor.orangeF4.op(0.1),
                    borderRadius: BorderRadius.circular(3.sp),
                  ),
                  child: AppText(
                    context.text.convertLimit,
                    style: AppStyle.text8.copyWith(color: AppCustomColor.orangeF1),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      '${context.text.decrease} $discountValueString',
                      style: AppStyle.text18.copyWith(fontWeight: FontWeight.w500),
                    ),
                    AppText(
                      context.text.orderDiscountCondition(voucher.discountCondition.shortCurrency, voucher.discountMax.shortCurrency),
                      style: AppStyle.text10.copyWith(fontWeight: FontWeight.w500),
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                    ),
                    AppText(
                      context.text.validUntil(voucher.expiredAt?.toLocalDateString ?? ''),
                      style: AppStyle.text10,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              20.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectedVoucherNotifier,
                    builder: (context, selectedVoucher, child) {
                      return Radio(
                        value: voucher,
                        groupValue: selectedVoucher,
                        onChanged: (voucher) {
                          selectedVoucherNotifier.value = voucher ?? Voucher();
                          onChanged?.call(voucher);
                        },
                      );
                    },
                  ),
                  16.verticalSpace,
                  GestureDetector(
                    onTap: () => _showVoucherPolicy(context),
                    child: AppText(
                      context.text.termsAndApply,
                      style: AppStyle.text10,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
