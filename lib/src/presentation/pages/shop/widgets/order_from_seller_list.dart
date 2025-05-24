part of '../shop.dart';

class OrdersFromSellerList extends StatelessWidget {
  final UserOrder order;

  const OrdersFromSellerList({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(AppAsset.images.logo.path, width: 20.w),
            14.horizontalSpace,
            AppText(
              order.store.name,
              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        12.verticalSpace,
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: order.orderProducts.length,
          itemBuilder: (context, index) => OrderFromSellerItem(
            orderProduct: order.orderProducts[index],
            orderStatus: order.status,
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                AppText(
                  context.text.note,
                  style: AppStyle.text12,
                ),
                4.horizontalSpace,
                Icon(Icons.edit_outlined, size: 14.sp),
              ],
            ),
            Spacer(),
            AppText(
              order.note,
              style: AppStyle.text12,
              onTap: () => viewNote(context),
            ),
          ],
        ),
        10.verticalSpace,
      ],
    );
  }

  void viewNote(BuildContext context) {
    showDModalBottomSheet(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      bodyWidget: NoteBody(
        title: context.text.note,
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
        controller: TextEditingController(),
        orderOverviewStoreInfo: OrderOverviewStoreInfo(),
      ),
    );
  }
}
