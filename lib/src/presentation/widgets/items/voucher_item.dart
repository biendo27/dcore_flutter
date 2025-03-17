part of '../widgets.dart';

class VoucherItem extends StatelessWidget {
  final Voucher voucher;
  const VoucherItem({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppCustomColor.orangeF4.op(0.1),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(voucher.name, style: AppStyle.textBold12),
              4.verticalSpace,
              DIconText(
                text: context.text.minimumSpending(voucher.discountCondition, voucher.discountCondition.currencyVND),
                icon: Icon(Icons.info_outline_rounded, size: 16.w),
                textStyle: AppStyle.text12,
                iconPosition: IconPosition.end,
                iconPlaceholderAlignment: PlaceholderAlignment.middle,
                onTap: () => _showVoucherPolicy(context),
              ),
            ],
          ),
          10.horizontalSpace,
          DButton(
            onPressed: () => context.read<ProductCubit>().saveVoucher(voucher.id),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            buttonType: DButtonType.outline,
            size: Size(53.w, 20.w),
            text: context.text.getVoucher,
            style: AppStyle.textBold12.copyWith(color: AppCustomColor.orangeF4),
          )
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
