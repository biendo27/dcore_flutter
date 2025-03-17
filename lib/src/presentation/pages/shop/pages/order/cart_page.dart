part of '../../shop.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ValueNotifier<List<Product>> productsNotifier = ValueNotifier([]);

  void _createOrder() {
    if (productsNotifier.value.isEmpty) {
      return;
    }

    UserBillingAddress defaultAddress = context.read<DeliveryAddressCubit>().state.defaultAddress;
    PaymentMethod paymentMethod = context.read<OrderPaymentMethodCubit>().state.paymentMethods.first;
    OrderOverviewInfo orderOverviewInfo = OrderOverviewInfo(
      paymentMethods: paymentMethod,
      billingAddress: defaultAddress,
      stores: productsNotifier.value.orderOverviewStoreInfos,
    );
    context.read<OrderCubit>()
      ..setOrderOverviewInfo(orderOverviewInfo)
      ..updateOrderInfo();

    DNavigator.replaceNamed(RouteNamed.orderSummary);
  }

  void _onSelectAll(bool? value, UserCart userCart) {
    List<Product> products = List.from(productsNotifier.value);
    if (products.length == userCart.allProductLength) {
      products.clear();
      productsNotifier.value = products;
      return;
    }
    products.addAll(userCart.details.map((d) => d.products).expand((x) => x));
    productsNotifier.value = products;
  }

  int get totalPrice => productsNotifier.value.fold(0, (previousValue, element) => previousValue + element.totalPrice);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return SubLayout(
          title: '${context.text.cart}(${state.userCart.totalQuantity})',
          isLoading: state.isLoading,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: state.userCart.details.isEmpty
                  ? [
                      NoData(message: context.text.noProductInCart),
                    ]
                  : [
                      ...state.userCart.details.map(
                        (e) => ShopCartItem(cartItem: e, productsNotifier: productsNotifier),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: productsNotifier,
                              builder: (context, value, child) {
                                return Checkbox(
                                  value: value.length == state.userCart.allProductLength,
                                  onChanged: (value) => _onSelectAll(value, state.userCart),
                                );
                              },
                            ),
                            AppText(
                              context.text.selectAll,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            ValueListenableBuilder(
                                valueListenable: productsNotifier,
                                builder: (context, value, child) {
                                  return AppText(
                                    totalPrice.currencyVND,
                                    style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.redD0),
                                  );
                                }),
                            8.horizontalSpace,
                            GradientButton(
                              text: context.text.payNow,
                              size: Size(150.w, 40.h),
                              onPressed: _createOrder,
                              style: AppStyle.text12.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                            ),
                          ],
                        ),
                      )
                    ],
            ),
          ),
        );
      },
    );
  }
}
