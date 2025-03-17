part of '../shop.dart';

class VoucherAndPromotionItem extends StatelessWidget {
  final Voucher voucher;

  const VoucherAndPromotionItem({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorLight.surface,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            offset: const Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DCachedImage(
            url: voucher.image,
            width: 50.w,
            height: 50.w,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.r),
              bottomLeft: Radius.circular(5.r),
            ),
          ),
          2.horizontalSpace,
          Padding(
            padding: EdgeInsets.all(4.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(voucher.displayTitle(context), style: AppStyle.text10),
                4.verticalSpace,
                Row(
                  children: [
                    SizedBox(
                      width: 78.w,
                      height: 25.h,
                      child: AppText(
                        context.text.minimumOrderCondition(voucher.discountCondition.shortCurrency),
                        style: AppStyle.text8.copyWith(fontWeight: FontWeight.w300),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DButton(
                      onPressed: () {
                        if (voucher.received) return;
                        context.read<ProductCubit>().saveVoucher(voucher.id);
                      },
                      text: voucher.received ? context.text.received : context.text.receive,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                      size: Size(40.w, 25.h),
                      style: AppStyle.text12.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: voucher.received ? AppCustomColor.greyE5 : AppColorLight.primary,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
