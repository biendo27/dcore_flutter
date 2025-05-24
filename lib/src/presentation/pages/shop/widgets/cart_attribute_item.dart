part of '../shop.dart';


class CartAttributeItem extends StatelessWidget {
  final Product product;
  final void Function() onPressed;
  const CartAttributeItem({super.key, required this.product, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (product.variant.isEmpty) return 30.verticalSpace;

    return InkWell(
      onTap: onPressed,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppCustomColor.greyF5,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              AppText(
                product.variantString,
                style: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down, size: 15.w),
            ],
          ),
        ),
      ),
    );
  }
}