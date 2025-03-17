part of '../shop.dart';

class ProductDescriptionInfo extends StatelessWidget {
  const ProductDescriptionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context.text.productDescription,
              style: AppStyle.text16.copyWith(
                fontWeight: FontWeight.w500,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.w),
            ),
            5.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: HtmlWidget(
                state.currentProductDetail.product.description,
                textStyle: AppStyle.text14,
              ),
            ),
            // ExpandableHtmlText(
            //   htmlText: state.currentProductDetail.product.description,
            //   padding: EdgeInsets.symmetric(horizontal: 10.w),
            //   maxLines: 10,
            // ),
            10.verticalSpace,
          ],
        );
      },
    );
  }
}
