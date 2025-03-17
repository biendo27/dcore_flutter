part of '../../setting.dart';

class FindCommissionProductPage extends StatefulWidget {
  const FindCommissionProductPage({super.key});

  @override
  State<FindCommissionProductPage> createState() => _FindCommissionProductPageState();
}

class _FindCommissionProductPageState extends State<FindCommissionProductPage> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();
  Timer searchDebounce = Timer(const Duration(milliseconds: 500), () {});
  late TabController _tabController;
  final ScrollController scrollController = ScrollController();
  int? type;

  @override
  void initState() {
    _initController();

    context.read<ProductFilterCubit>().fetchProductFilter();
    context.read<AffiliateCubit>().filterProductData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent
          && context.read<AffiliateCubit>().state.products.length%10==0){
        context.read<AffiliateCubit>().filterProductData(isLoadMore: true);
      }});
    super.didChangeDependencies();
  }

  _initController() {
    _tabController = TabController(length: SortOption.values.length, vsync: this);
    searchController.text = context.read<ProductFilterCubit>().state.keyword;
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      enableAppBar: false,
      endDrawer: FindProductFilterDrawer(
        fromPriceController: fromPriceController,
        toPriceController: toPriceController,
      ),
      isLoading: context.select((ProductFilterCubit cubit) => cubit.state.isLoading),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            40.verticalSpace,
            SummissionProductFilterHeader(
                searchController: searchController,
                onSearch: (newValue) {
                  searchDebounce.cancel();
                  searchDebounce = Timer(const Duration(milliseconds: 500), () {
                    context.read<ProductFilterCubit>().changeKeyword(newValue);

                    context.read<AffiliateCubit>().filterProductData();
                  });
                }),
            CommissionProductFilterTabbar(tabController: _tabController),
            12.verticalSpace,
            CommissionProductFilterSubMenu(),
            16.verticalSpace,
            CommissionProductFilterResult(),
          ],
        ),
      ),
    );
  }
}
