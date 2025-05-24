part of '../widgets.dart';

class ListVoucherProductItem extends StatelessWidget {
  final Voucher voucher;

  const ListVoucherProductItem({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.sp),
        border: Border.all(color: AppCustomColor.orangeF1, width: 0.2.w),
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
          4.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText('${context.text.decrease} ${voucher.discountValueString}', style: AppStyle.text18.copyWith(fontWeight: FontWeight.w500)),
                    4.verticalSpace,
                    AppText(
                      context.text.orderDiscountCondition(voucher.discountCondition.shortCurrency, voucher.discountMaxString),
                      style: AppStyle.text10.copyWith(fontWeight: FontWeight.w500),
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                    ),
                    4.verticalSpace,
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
                  DButton(
                    onPressed: () {
                      if (voucher.received) return;
                      context.read<ProductCubit>().saveVoucher(voucher.id);
                    },
                    text: voucher.received ? context.text.codeClaimed : context.text.getVoucher,
                    size: Size(95.w, 30.h),
                    style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
                    backgroundColor: voucher.received ? AppCustomColor.greyE5 : AppColorLight.primary,
                    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
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

  void _showVoucherPolicy(BuildContext context) {
    context.read<LiveCubit>().fetchVoucherUsageTerms(voucher.id);
    showDataBottomSheet(
      title: context.text.termsAndConditions,
      bodyWidget: VoucherTermBody(),
    );
  }
}
