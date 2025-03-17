part of '../shop.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late CountDownController countDownController;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() {
    StoreFlashSale flashSale = context.read<StoreHomeCubit>().state.storeHome.flashSale;
    int initialCountdown = flashSale.endTime?.diffTimeInSeconds(DateTime.now()) ?? 0;
    countDownController = CountDownController(
      isFullFormat: true,
      initialCountdown: initialCountdown,
      onStartCount: () {},
      onEndCount: () {},
    );
    countDownController.start();
    context
      ..read<CartCubit>().fetchUserCart()
      ..read<ProductFilterCubit>().fetchProductFilter()
      ..read<DeliveryAddressCubit>().fetchBillingAddresses()
      ..read<OrderPaymentMethodCubit>().fetchPaymentMethods()
      ..read<ProductSuggestCubit>().fetchProductSuggest()
      ..read<LiveCubit>().getLiveList(isInit: true);

    context.read<ProductCubit>()
      ..fetchProductService()
      ..fetchProductCancelOrderTutorialTerm();
  }

  @override
  void dispose() {
    countDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: SizedBox(
          height: 40,
          child: Center(
            child: TextField(
              onTap: () {
                context.read<SearchCubit>()
                  ..setCurrentKeyword('')
                  ..fetchListKeyword()
                  ..fetchSearchHistory();
                DNavigator.goNamed(RouteNamed.findProduct);
              },
              readOnly: true,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: context.text.search,
                hintStyle: TextStyle(height: 1),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        ),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return CustomCart(
                number: state.userCart.allProductLength,
                onTap: () {
                  context.read<CartCubit>().fetchUserCart();
                  DNavigator.goNamed(RouteNamed.cart);
                },
              );
            },
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          14.verticalSpace,
          ShopCategory(),
          14.verticalSpace,
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<StoreHomeCubit>().fetchStoreHome(onSuccess: () {
                  _initData();
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ShopBanner(),
                    ShopFlashSale(countDownController: countDownController),
                    ShopCategoryInfo(),
                    BlocBuilder<StoreHomeCubit, StoreHomeState>(
                      builder: (context, state) {
                        return Container(
                          child: state.storeHome.events.isNotEmpty ? ShopEvent() : SizedBox(),
                        );
                      },
                    ),
                    ShopProduct(),
                    50.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
