part of '../shop.dart';

class CancelOrderProductItem extends StatelessWidget {
  final Product product;

  const CancelOrderProductItem({
    super.key,
    required this.product,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Row(
        children: [
          DCachedImage(url: product.thumbnail, width: 70.w, height: 70.w, fit: BoxFit.cover),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  product.name.toUpperCase(),
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                ),
                30.verticalSpace,
                AppText("${context.text.quantity} x${product.quantity}", style: AppStyle.text12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
