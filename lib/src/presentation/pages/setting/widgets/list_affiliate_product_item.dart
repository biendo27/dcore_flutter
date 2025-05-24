part of '../setting.dart';

class ListAffiliateProductItem extends StatelessWidget {
  const ListAffiliateProductItem({
    super.key,
    required this.product,
    this.isCopied = false,
    this.isAdded = false,
  });
  final ProductAffiliate product;
  final bool isCopied;
  final bool isAdded;

  void addProduct(BuildContext context) {
    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      bodyWidget: AddCommissionProductBodyBottomSheet(
        title: context.text.productDetail,
        product: product,
      ),
    );
  }

  String get image {
    if (product.images.isEmpty) return AppAsset.images.myWife.path;

    return product.images.first;
  }

  String status(BuildContext context) {
    return product.stock == 0 ? context.text.outOfStock : context.text.inStockLabel;
  }

  Color statusColor(BuildContext context) {
    return product.stock == 0 ? AppCustomColor.redD0 : AppCustomColor.green0F;
  }

  String iconButton(BuildContext context) {
    return isCopied ? AppAsset.svg.copy : AppAsset.svg.add;
  }

  String textButton(BuildContext context) {
    return isCopied ? context.text.copy : context.text.add;
  }

  Widget buyProductWidget(BuildContext context) {
    return Row(
      children: [
        DButton(
          onPressed: isCopied
              ? () async {
                  await Clipboard.setData(ClipboardData(text: product.link));
                }
              : () => addProduct(context),
          customChild: SvgPicture.asset(iconButton(context), width: 20.w, height: 20.h),
          size: Size(40.w, 35.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          style: AppStyle.text14.copyWith(color: AppColorLight.surface),
          backgroundColor: AppCustomColor.greyDA,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(5.r))),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        DButton(
          onPressed: isCopied
              ? () async {
                  debugPrint("cascasvasvas ${product.link}");
                  await Clipboard.setData(ClipboardData(text: product.link));
                  DMessage.showMessage(message: "Copy thành công", type: MessageType.success);
                }
              : () => addProduct(context),
          text: textButton(context),
          size: Size(70.w, 35.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          style: AppStyle.text14.copyWith(color: AppColorLight.surface),
          backgroundColor: AppCustomColor.orangeF1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(5.r))),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  void onPressCopy() async {
    await Clipboard.setData(ClipboardData(text: product.link));
    DMessage.showMessage(message: "Copy thành công", type: MessageType.success);
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
                AppText(product.name, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                5.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAsset.svg.giveCoinHand, width: 12.w, height: 12.h),
                    5.horizontalSpace,
                    AppText(
                      "${product.commissionValue} ${context.text.commission.toLowerCase()}",
                      style: AppStyle.text12
                          .copyWith(color: AppColorLight.onSurface.op(0.75), fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        color: statusColor(context).op(0.1),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: AppText(status(context),
                          style: AppStyle.text8.copyWith(color: statusColor(context), fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.discount != 0)
                            Row(
                              children: [
                                AppText(
                                  product.price.currencyVND,
                                  style: AppStyle.text10.copyWith(
                                    color: AppCustomColor.redD0,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                5.horizontalSpace,
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: AppCustomColor.redD0.op(0.1),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: AppText(
                                    "-${product.discount}%",
                                    style: AppStyle.text10.copyWith(color: AppCustomColor.redD0),
                                  ),
                                ),
                              ],
                            ),
                          AppText(
                            product.discountedPrice.currencyVND,
                            style: AppStyle.text12.copyWith(color: AppColorLight.onSurface),
                          ),
                        ],
                      ),
                    ),
                    buyProductWidget(context),
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
