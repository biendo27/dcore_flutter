part of '../../shop.dart';

class ResultFindProductPage extends StatefulWidget {
  const ResultFindProductPage({super.key});

  @override
  State<ResultFindProductPage> createState() => _ResultFindProductPageState();
}

class _ResultFindProductPageState extends State<ResultFindProductPage> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();
  Timer searchDebounce = Timer(const Duration(milliseconds: 500), () {});
  late TabController _tabController;

  @override
  void initState() {
    _initController();
    super.initState();
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
            ProductFilterHeader(
                searchController: searchController,
                onSearch: (newValue) {
                  searchDebounce.cancel();
                  searchDebounce = Timer(const Duration(milliseconds: 500), () {
                    context.read<ProductFilterCubit>()
                      ..changeKeyword(newValue)
                      ..searchProduct();
                  });
                }),
            ProductFilterTabbar(tabController: _tabController),
            12.verticalSpace,
            ProductFilterSubMenu(),
            16.verticalSpace,
            ProductFilterResult(),
          ],
        ),
      ),
    );
  }
}
