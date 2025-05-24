part of '../livestream.dart';

class VoucherWidget extends StatelessWidget {
  const VoucherWidget({super.key});

  String voucherCount(int count) {
    return count < 9 ? count.toString() : '9+';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _viewFullVoucher,
      child: BlocBuilder<LiveCubit, LiveState>(
        builder: (context, state) {
          return Badge(
            label: AppText(voucherCount(state.liveBooth.vouchers.length), style: AppStyle.text12.copyWith(color: AppThemeMaterial.lightColorScheme.onPrimary)),
            isLabelVisible: state.liveBooth.vouchers.isNotEmpty,
            offset: Offset(0, 18),
            child: Image.asset(
              AppAsset.images.voucher.path,
              width: 40.w,
            ),
          );
        },
      ),
    );
  }

  void _viewFullVoucher() {
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: ListVoucherProductBody(),
    );
  }
}
