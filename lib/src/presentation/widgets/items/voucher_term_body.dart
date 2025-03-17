part of '../widgets.dart';

class VoucherTermBody extends StatelessWidget {
  const VoucherTermBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveCubit, LiveState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: AppLoading());
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              AppText(context.text.voucherDetails, style: AppStyle.textBold16),
              ...state.voucherUsageTerms.voucher.detail.map((e) => AppText(e, style: AppStyle.text14.copyWith(color: AppCustomColor.grey50), maxLines: 10)),
              10.verticalSpace,
              AppText(context.text.validityPeriod, style: AppStyle.textBold16),
              AppText(context.text.expirationAfter(state.voucherUsageTerms.voucher.expiredAt?.toLocalDateString ?? ''),
                  style: AppStyle.text14.copyWith(color: AppCustomColor.grey50)),
              10.verticalSpace,
              AppText(context.text.limit, style: AppStyle.textBold16),
              AppText(state.voucherUsageTerms.voucher.limit.toString(), style: AppStyle.text14.copyWith(color: AppCustomColor.grey50)),
              10.verticalSpace,
              AppText(context.text.usageLimit, style: AppStyle.textBold16),
              AppText(state.voucherUsageTerms.voucher.stock, style: AppStyle.text14.copyWith(color: AppCustomColor.grey50)),
              10.verticalSpace,
              AppText(context.text.termsAndConditions, style: AppStyle.textBold16),
              HtmlWidget(state.voucherUsageTerms.term),
            ],
          ),
        );
      },
    );
  }
}
