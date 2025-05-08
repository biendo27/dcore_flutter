part of '../../shop.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController();

  @override
  void initState() {
    context.read<CartCubit>().fetchUserCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<ProductCubit>().state.isLoading;
    if (isLoading) return const AppLoading();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: InkWell(
          onTap: DNavigator.back,
          child: Icon(FontAwesomeIcons.arrowLeft, size: 24.sp),
        ),
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
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => SharePlus.instance.share(ShareParams(
                  text: state.currentProductDetail.product.link,
                )),
                child: SvgPicture.asset(AppAsset.svg.shareBold, width: 24.w, height: 24.h),
              );
            },
          ),
          12.horizontalSpace,
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
          5.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductIntroImages(pageController: _pageController),
                  ProductIntroInfo(),
                  ProductVoucherInfo(),
                  ProductReviewInfo(),
                  ProductVideoInfo(),
                  ProductDescriptionInfo(),
                  ProductOtherInfo(),
                ],
              ),
            ),
          ),
          ProductBottomAction(),
        ],
      ),
    );
  }
}
