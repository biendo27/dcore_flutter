part of '../../shop.dart';

class FlashSalePage extends StatefulWidget {
  const FlashSalePage({super.key});

  @override
  State<FlashSalePage> createState() => _FlashSalePageState();
}

class _FlashSalePageState extends State<FlashSalePage> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      enableAppBar: false,
      isLoading: context.select((FlashSaleCubit bloc) => bloc.state.isLoading),
      body: Column(
        children: [
          40.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.horizontalSpace,
              InkWell(
                onTap: DNavigator.back,
                child: Icon(FontAwesomeIcons.arrowLeft, size: 24.sp),
              ),
              10.horizontalSpace,
              SearchTextfield(
                expandFlex: 1,
                controller: _searchController,
                readOnly: true,
                onTap: () {
                  context.read<SearchCubit>().fetchSearchHistory();
                  DNavigator.goNamed(RouteNamed.findProduct);
                },
              ),
              10.horizontalSpace,
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
            ],
          ),
          20.verticalSpace,
          FlashSaleBanner(pageController: _pageController),
          7.verticalSpace,
          FlashSaleTimeIntro(),
          10.verticalSpace,
          FlashSaleProductData(),
        ],
      ),
    );
  }
}
