part of '../shop.dart';

class OrderSummaryShopProductInfo extends StatelessWidget {
  final OrderOverviewStoreInfo storeInfo;
  final TextEditingController controller;
  const OrderSummaryShopProductInfo({
    super.key,
    required this.storeInfo,
    required this.controller,
  });

  void viewDiscountFromSellerBody(BuildContext context) {
    context.read<OrderCubit>().getStoreVouchers(isInit: true, storeInfo: storeInfo);
    showDModalBottomSheet(
      enableDrag: false,
      isDismissible: true,
      isScrollControlled: true,
      contentPadding: EdgeInsets.zero,
      bodyWidget: DiscountFromSellerBody(
        title: context.text.discountFromSeller,
        storeInfo: storeInfo,
      ),
    );
  }

  void editNote(BuildContext context) {
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      initialChildSize: 0.3,
      bodyWidget: EditNoteBody(
        title: context.text.note,
        controller: controller,
        orderOverviewStoreInfo: storeInfo,
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
        children: [
          Row(
            children: [
              Image.asset(AppAsset.images.logo.path, width: 20.w, height: 20.w),
              14.horizontalSpace,
              AppText(
                storeInfo.infor.name,
                style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.onSurface),
              ),
            ],
          ),
          ...storeInfo.items.map((e) => ItemProductOrderSummary(product: e)),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppText(
                onTap: () => viewDiscountFromSellerBody(context),
                context.text.discountFromSeller,
                style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.blue1F),
              ),
              if (storeInfo.storeVoucher.discountAmount != 0) ...[
                4.horizontalSpace,
                AppText(
                  storeInfo.storeVoucher.discountAmount.currencyVND,
                  style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.redD0),
                ),
              ]
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                context.text.delivery(storeInfo.shippingMethod.name),
                style: AppStyle.text14,
              ),
              DeliveryInfo(shippingMethod: storeInfo.shippingMethod),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppAsset.svg.mapPin,
                width: 12.w,
                height: 12.w,
              ),
              4.horizontalSpace,
              Expanded(
                // Đảm bảo không bị tràn
                child: AppText(
                  storeInfo.shippingMethod.storeAddress,
                  maxLines: 2, // Giới hạn tối đa 2 dòng
                  overflow: TextOverflow.ellipsis, // Thêm dấu "..." nếu vượt quá 2 dòng// Cho phép xuống dòng tự nhiên
                  style: AppStyle.text12.copyWith(fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppAsset.svg.freeShipping,
                width: 18.w,
                height: 18.w,
              ),
              6.horizontalSpace,
              AppText(
                "${context.text.expected}: ${storeInfo.shippingMethod.expectedTimeText}",
                style: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
              ),
              Spacer(),
              AppText(
                context.text.note,
                style: AppStyle.text14,
                onTap: () => editNote(context),
              ),
              4.horizontalSpace,
              InkWell(
                onTap: () => editNote(context),
                child: Icon(Icons.edit_outlined, size: 16.w, color: AppColorLight.onSurface),
              ),
              10.verticalSpace,
            ],
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(context.text.total, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
              DHighlightText(
                text: context.text.quantityTotal(storeInfo.totalQuantity, storeInfo.totalPrice.currencyVND),
                highlights: [storeInfo.totalQuantity.toString(), storeInfo.totalPrice.currencyVND],
                highlightStyles: [
                  AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                  AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ],
                style: AppStyle.text14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  final ShippingMethod shippingMethod;
  const DeliveryInfo({super.key, required this.shippingMethod});

  @override
  Widget build(BuildContext context) {
    if (shippingMethod.discountedAmount == 0) {
      return AppText(shippingMethod.fee.currencyVND, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500));
    }

    if (shippingMethod.discountedAmount == shippingMethod.fee) {
      return Row(
        children: [
          SvgPicture.asset(AppAsset.svg.freeShipping, width: 18.w, height: 18.w),
          4.horizontalSpace,
          DHighlightText(
            text: "Free (${shippingMethod.fee.currencyVND})",
            highlights: [shippingMethod.fee.currencyVND],
            highlightStyles: [AppStyle.text12.copyWith(decoration: TextDecoration.lineThrough, fontWeight: FontWeight.w300)],
            style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    if (shippingMethod.discountedAmount != 0 && shippingMethod.discountedAmount != shippingMethod.fee) {
      return Column(
        children: [
          AppText(shippingMethod.discountedAmount.currencyVND, style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500)),
          4.verticalSpace,
          DHighlightText(
            text: "(${shippingMethod.fee.currencyVND})",
            highlights: [shippingMethod.fee.currencyVND],
            highlightStyles: [AppStyle.text12.copyWith(decoration: TextDecoration.lineThrough, fontWeight: FontWeight.w300)],
            style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    return SizedBox.shrink();
  }
}
