part of '../shop.dart';

class ProductVoucherInfo extends StatelessWidget {
  const ProductVoucherInfo({super.key});

  void _viewFullVoucher() {
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: ListVoucherProductBody(type: VoucherType.product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.vouchers.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            ShopTitleItem(
              title: context.text.voucherAndPromotion,
              onTap: _viewFullVoucher,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
            ),
            10.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 52.h,
              child: ListView.separated(
                itemCount: state.vouchers.length,
                separatorBuilder: (context, index) => 4.horizontalSpace,
                itemBuilder: (context, index) => VoucherAndPromotionItem(
                  voucher: state.vouchers[index],
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            16.verticalSpace,
          ],
        );
      },
    );
  }
}
