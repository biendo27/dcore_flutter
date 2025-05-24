part of '../shop.dart';

class ShopCartItem extends StatelessWidget {
  final ShopCartInfo cartItem;
  final ValueNotifier<List<Product>> productsNotifier;
  const ShopCartItem({
    super.key,
    required this.cartItem,
    required this.productsNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(AppAsset.images.logo.path, width: 20.w, height: 20.w),
            14.horizontalSpace,
            AppText(
              "${cartItem.store.name}(${cartItem.totalQuantity})",
              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.onSurface),
            ),
          ],
        ),
        12.verticalSpace,
        if (cartItem.products.isNotEmpty)
          ...cartItem.products.map((e) => CartItem(
                product: e,
                productsNotifier: productsNotifier,
              )),
      ],
    );
  }
}
