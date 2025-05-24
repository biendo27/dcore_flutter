part of '../../shop.dart';

class FindProductPage extends StatefulWidget {
  const FindProductPage({super.key});

  @override
  State<FindProductPage> createState() => _FindProductPageState();
}

class _FindProductPageState extends State<FindProductPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer searchDebounce = Timer(Duration.zero, () {});

  double getGripviewChildAspectRatio(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return ((width - 47.w) / 2) / 188.h;
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      enableAppBar: false,
      isLoading: context.select((SearchCubit cubit) => cubit.state.isLoading),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.verticalSpace,
            Row(
              children: [
                InkWell(
                  onTap: DNavigator.back,
                  child: Icon(FontAwesomeIcons.arrowLeft, size: 24.sp),
                ),
                SearchTextfield(
                  expandFlex: 1,
                  controller: _searchController,
                  margin: EdgeInsets.only(left: 16.w),
                  onSubmit: (value) {
                    if (value == null) return;
                    context.read<ProductFilterCubit>()
                      ..resetSelectedFilter()
                      ..changeKeyword(value as String)
                      ..searchProduct();

                    context.read<SearchCubit>()
                      ..saveKeywordHistory(value)
                      ..setKeywords([]);

                    DNavigator.replaceNamed(RouteNamed.resultFindProduct);
                  },
                  onChanged: (newValue) {
                    searchDebounce.cancel();
                    searchDebounce = Timer(Duration(milliseconds: 800), () {
                      context.read<SearchCubit>()
                        ..setCurrentKeyword(newValue)
                        ..fetchListKeyword();
                    });
                  },
                ),
              ],
            ),
            SuggestedProductKeywords(),
            10.verticalSpace,
            AppText(context.text.suggestedProducts, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
            5.verticalSpace,
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 13.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: getGripviewChildAspectRatio(context),
                  ),
                  itemCount: state.searchHistory.products.length,
                  itemBuilder: (context, index) {
                    return SuggestedProductsItem(
                      product: state.searchHistory.products[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
