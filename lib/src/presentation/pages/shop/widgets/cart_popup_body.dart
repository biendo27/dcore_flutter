part of '../shop.dart';

enum CartPopupType {
  buyNow,
  addToCart,
  updateCart,
}

class CartPopupBody extends StatefulWidget {
  final CartPopupType type;
  const CartPopupBody({
    super.key,
    required this.type,
  });
  @override
  State<CartPopupBody> createState() => _CartPopupBodyState();
}

class _CartPopupBodyState extends State<CartPopupBody> {
  ValueNotifier<int> quantityNotifier = ValueNotifier(1);
  List<ValueNotifier<AttributeValue>> attributeNotifier = [];

  @override
  void initState() {
    super.initState();
    _initAttributeNotifier();
  }

  void _initAttributeNotifier() {
    final product = context.read<CartCubit>().state.productCart;
    if (product.variant.isNotEmpty) {
      for (var attribute in product.variant) {
        attributeNotifier.add(ValueNotifier(attribute));
      }
      return;
    }
    for (var attribute in product.attributes) {
      attributeNotifier.add(ValueNotifier(attribute.values.first));
    }
  }

  String get title {
    if (widget.type == CartPopupType.buyNow) {
      return context.text.buyNow;
    }

    if (widget.type == CartPopupType.updateCart) {
      return context.text.updateCart;
    }

    return context.text.addToCart;
  }

  String get buttonText {
    if (widget.type == CartPopupType.buyNow) {
      return context.text.buyNow;
    }

    if (widget.type == CartPopupType.updateCart) {
      return context.text.updateCart;
    }

    return context.text.addToCart;
  }

  void _onPressed(Product product) {
    if (widget.type == CartPopupType.addToCart) {
      context.read<CartCubit>().addToCart(product, quantityNotifier.value, attributeNotifier.map((e) => e.value).toList());
      return;
    }

    if (widget.type == CartPopupType.updateCart) {
      context.read<CartCubit>().updateCartProduct(
            product: product,
            quantity: quantityNotifier.value,
            attributeValues: attributeNotifier.map((e) => e.value).toList(),
            onSuccess: DNavigator.back,
          );
      return;
    }

    UserBillingAddress defaultAddress = context.read<DeliveryAddressCubit>().state.defaultAddress;
    PaymentMethod paymentMethod = context.read<OrderPaymentMethodCubit>().state.paymentMethods.first;
    Product productCart = context.read<CartCubit>().state.productCart;
    productCart = productCart.copyWith(quantity: quantityNotifier.value, variant: attributeNotifier.map((e) => e.value).toList());

    OrderOverviewInfo orderOverviewInfo = OrderOverviewInfo(
      paymentMethods: paymentMethod,
      billingAddress: defaultAddress,
      stores: [productCart].orderOverviewStoreInfos,
    );

    context.read<OrderCubit>()
      ..setOrderOverviewInfo(orderOverviewInfo)
      ..updateOrderInfo();

    DNavigator.back();
    DNavigator.replaceNamed(RouteNamed.orderSummary);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.75.sh - MediaQuery.viewInsetsOf(context).bottom,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 56.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppCustomColor.greyF5,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                child: AppText(
                  title,
                  style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                ),
              ),
              20.verticalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductCartOverview(product: state.productCart),
                    20.verticalSpace,
                    ProductCartVariantInfo(
                      attributes: state.productCart.attributes,
                      attributeNotifiers: attributeNotifier,
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        16.horizontalSpace,
                        AppText(
                          context.text.quantity,
                          style: AppStyle.text12.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        IncreaseOrDecreaseQuantity(quantityNotifier: quantityNotifier),
                        16.horizontalSpace,
                      ],
                    ),
                  ],
                ),
              ),
              GradientButton(
                size: Size(360.w, 50.h),
                style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                text: buttonText,
                onPressed: () => _onPressed(state.productCart),
              ),
              20.verticalSpace,
            ],
          );
        },
      ),
    );
  }
}
