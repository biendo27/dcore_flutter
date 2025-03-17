part of '../setting.dart';
class HistoryTransactionCommissionState {
  static const String success = 'success';
  static const String pending = 'pending';
  static const String cancel = 'cancel';
}
class ListHistoryTransactionItem extends StatelessWidget {
  const ListHistoryTransactionItem({
    super.key,
    required this.data
  });
  final TransactionCommissionData data;

  String get image {
    if (data.product.product.images.isEmpty) return AppAsset.images.myWife.path;

    return data.product.product.images.first;
  }

  String statusTransaction(BuildContext context) {
    switch(data.status) {
      case HistoryTransactionCommissionState.success:
        return context.text.successTitle;
      case HistoryTransactionCommissionState.pending:
        return context.text.pending;
      case HistoryTransactionCommissionState.cancel:
        return context.text.canceled;
    }
    // if (isShipping) return context.text.shipping;

    return context.text.pending;
  }

  Color backgroundStatus() {
    switch(data.status) {
      case HistoryTransactionCommissionState.success:
        return AppCustomColor.green0F;
      case HistoryTransactionCommissionState.pending:
        return AppCustomColor.yellowF5;
      case HistoryTransactionCommissionState.cancel:
        return AppCustomColor.redD0;
    }
    // if (isShipping) return AppCustomColor.blue4A;

    return AppCustomColor.yellowFF;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColorLight.surface,
        border: Border.all(color: AppCustomColor.greyAC, width: 0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          DCachedImage(
            borderRadius: BorderRadius.circular(10.r),
            url: image,
            width: 74.w,
            height: 74.w,
            fit: BoxFit.cover,
            onTap: () {},
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(data.product.product.name, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                5.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: data.product.product.attributes.map((e) {
                              if (data.product.product.attributes.last == e) {
                                return AppText(e.values.first.value, style: AppStyle.text12.copyWith(color: AppColorLight.onSurface));
                              }
                              return AppText("${e.values.first.value}, ", style: AppStyle.text12.copyWith(color: AppColorLight.onSurface));
                            }).toList(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppAsset.svg.giveCoinHand, width: 12.w, height: 12.h),
                              5.horizontalSpace,
                              AppText(
                                "5% ${context.text.commission.toLowerCase()}",
                                style: AppStyle.text12.copyWith(color: AppColorLight.onSurface.op(0.75), fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          5.verticalSpace,
                          AppText(
                            data.product.product.price.currencyVND,
                            style: AppStyle.text12.copyWith(color: AppCustomColor.redD0),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            constraints: BoxConstraints(minWidth: 80.w),
                            padding: EdgeInsets.all(4.sp),
                            decoration: BoxDecoration(
                              color: backgroundStatus(),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            alignment: Alignment.center,
                            child: AppText(statusTransaction(context), style: AppStyle.text8.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500)),
                          ),
                          AppText(data.code, style: AppStyle.text12.copyWith(color: AppColorLight.onSurface, overflow: TextOverflow.ellipsis)),
                          AppText(data.createdAtFormat, style: AppStyle.text10.copyWith(color: AppCustomColor.greyAC, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
