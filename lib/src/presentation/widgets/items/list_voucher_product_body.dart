part of '../widgets.dart';

enum VoucherType { product, live }

class ListVoucherProductBody extends StatelessWidget {
  final VoucherType type;
  
  const ListVoucherProductBody({
    super.key,
    this.type = VoucherType.live,
  });

  Widget _voucherBody(BuildContext context) {
    switch (type) {
      case VoucherType.product:
        return BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return VoucherListBody(vouchers: state.vouchers);
          },
        );
      case VoucherType.live:
        return BlocBuilder<LiveCubit, LiveState>(
          builder: (context, state) {
            return VoucherListBody(vouchers: state.liveBooth.vouchers);
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 0.75.sh),
        _background(),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    10.horizontalSpace,
                    Image.asset(
                      AppAsset.gif.congratulations.path,
                      width: 40.sp,
                      height: 40.sp,
                    ),
                    5.horizontalSpace,
                    AppText(
                      context.text.congratulationReceiveVoucher,
                      style: AppStyle.text12.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                20.verticalSpace,
                Expanded(child: _voucherBody(context)),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _background() {
    return Container(
      height: 80.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF58822).op(0.5),
            Colors.white,
          ],
        ),
      ),
    );
  }
}

class VoucherListBody extends StatelessWidget {
  final List<Voucher> vouchers;
  const VoucherListBody({
    super.key,
    this.vouchers = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (vouchers.isEmpty) {
      return NoData(message: context.text.collectedAllShopVouchers);
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        return ListVoucherProductItem(
          voucher: vouchers[index],
        );
      },
    );
  }
}
