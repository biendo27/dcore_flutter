part of '../shop.dart';

class CartItem extends StatelessWidget {
  final int shopId;
  final Product product;
  final ValueNotifier<List<Product>> productsNotifier;
  const CartItem({
    super.key,
    this.shopId = 0,
    required this.product,
    required this.productsNotifier,
  });

  void _updateCart(BuildContext context) {
    context.read<CartCubit>()
      ..setProductCart(product)
      ..getProductByVariant(product.attributes.map((e) => e.values.first).toList());

    showDModalBottomSheet(
      contentPadding: EdgeInsets.zero,
      maxChildSize: 0.75,
      enableDrag: false,
      initialChildSize: 0.75,
      bodyWidget: CartPopupBody(type: CartPopupType.updateCart),
    );
  }

  void _onSelect(bool? value) {
    List<Product> products = List.from(productsNotifier.value);
    if (products.contains(product)) {
      products.remove(product);
      productsNotifier.value = products;
      return;
    }
    products.add(product);
    productsNotifier.value = products;
  }

  void removeOldProductAfterUpdateCart() {
    List<Product> products = List.from(productsNotifier.value);
    products.remove(product);
    productsNotifier.value = products;
  }

  void _increaseQuantity(BuildContext context) {
    context.read<CartCubit>().increaseCartProductQuantity(product: product, onSuccess: removeOldProductAfterUpdateCart);
  }

  void _decreaseQuantity(BuildContext context) {
    context.read<CartCubit>().decreaseCartProductQuantity(product: product, onSuccess: removeOldProductAfterUpdateCart);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: AppCustomColor.redD0,
            onPressed: (context) => context.read<CartCubit>().deleteCartProduct(product),
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DCachedImage(url: product.thumbnail, width: 68.w, height: 74.w),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    product.name,
                    style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CartAttributeItem(
                              product: product,
                              onPressed: () => _updateCart(context),
                            ),
                            4.verticalSpace,
                            AppText(
                              product.discountedPrice.currencyVND,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.redD0),
                            ),
                          ],
                        ),
                      ),
                      IncreaseOrDecreaseQuantityCart(
                        quantity: product.quantity,
                        increment: () => _increaseQuantity(context),
                        decrement: () => _decreaseQuantity(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: productsNotifier,
                builder: (context, value, child) {
                  return Checkbox(
                    value: value.contains(product),
                    onChanged: _onSelect,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
