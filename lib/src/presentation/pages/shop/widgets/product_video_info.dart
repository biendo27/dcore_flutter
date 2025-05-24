part of '../shop.dart';

class ProductVideoInfo extends StatelessWidget {
  const ProductVideoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.currentProductDetail.posts.isEmpty) return const SizedBox.shrink();
        if (!kDebugMode) return const SizedBox.shrink();

        return Column(
          children: [
            ShopTitleItem(
              title: context.text.videoProduct,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
            ),
            10.verticalSpace,
            Container(
              height: 230.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: ListView.separated(
                separatorBuilder: (context, index) => 10.horizontalSpace,
                itemBuilder: (context, index) => VideoProductItem(
                  onTap: () {
                    DNavigator.goNamed(RouteNamed.videoProduct);
                  },
                ),
                itemCount: 2,
                scrollDirection: Axis.horizontal,
              ),
            ),
            10.verticalSpace,
          ],
        );
      },
    );
  }
}
