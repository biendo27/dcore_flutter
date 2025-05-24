part of '../shop.dart';


class UserPendingReviewItem extends StatelessWidget {
  final OrderProduct orderProduct;

  const UserPendingReviewItem({
    super.key,
    required this.orderProduct,
  });

  void sendEvaluate(BuildContext context) {
    context.read<OrderActionCubit>().setActionImages([]);

    showDModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      bodyWidget: EvaluateBody(orderProductIds: [orderProduct.id]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DIconText(
            icon: Icon(Icons.store_mall_directory_rounded),
            text: orderProduct.product.store.name,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: DCachedImage(
              url: orderProduct.product.thumbnail,
              width: 50.w,
              height: 50.h,
              borderRadius: BorderRadius.circular(10.r),
            ),
            title: AppText(orderProduct.product.name),
            subtitle: AppText(
              orderProduct.product.description.parseHtml,
              style: AppStyle.text12.copyWith(color: AppCustomColor.greyAC),
              maxLines: 2,
            ),
          ),
          Row(
            children: [
              DButton(
                size: Size(100.w, 30.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                text: context.text.review,
                style: AppStyle.text12.copyWith(color: AppColorLight.onPrimary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                onPressed: () => sendEvaluate(context),
              ),
              Spacer(),
              DIconText(
                icon: Image.asset(AppAsset.images.coin.path, width: 20.w),
                spacing: 5.w,
                text: '100 - 200',
              )
            ],
          ),
        ],
      ),
    );
  }
}
