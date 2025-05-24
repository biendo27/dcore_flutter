part of '../shop.dart';

class CatalogItem extends StatelessWidget {
  final StoreCategory category;
  final void Function()? onTap;

  const CatalogItem({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductFilterCubit>()
          ..resetSelectedFilter()
          ..changeSelectedCategory(category)
          ..searchProduct();
        DNavigator.goNamed(RouteNamed.resultFindProduct);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.w),
        width: 55.w,
        child: Column(
          children: [
            DCachedImage(
              url: category.image,
              width: 40.w,
              height: 40.w,
              fit: BoxFit.cover,
            ),
            7.verticalSpace,
            AppText(
              category.name,
              style: AppStyle.text10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
