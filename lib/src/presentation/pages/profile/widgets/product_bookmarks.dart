part of '../profile.dart';

class ProductBookmarks extends StatelessWidget {
  final bool isLoading;
  final List<Product> products;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onFetch;
  const ProductBookmarks({
    super.key,
    this.isLoading = false,
    this.products = const [],
    required this.onRefresh,
    required this.onFetch,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppLoading();
    }

    if (products.isEmpty) {
      return Column(
        children: [
          20.verticalSpace,
          Image.asset(AppAsset.images.itemNotFound.path, width: 125.w),
          AppText(
            context.text.emptyList,
            style: AppStyle.textBold14,
          ),
        ],
      );
    }
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ProductItem(product: products[index]);
      },
    );
  }
}
