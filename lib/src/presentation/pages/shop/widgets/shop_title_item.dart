part of '../shop.dart';

class ShopTitleItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final String? endTime;
  final Widget? prefix;
  final Widget? bonus;
  final EdgeInsetsGeometry? padding;
  final bool isViewAll;
  final int expandFlex;

  const ShopTitleItem({
    super.key,
    required this.title,
    this.onTap,
    this.endTime,
    this.prefix,
    this.bonus,
    this.padding,
    this.isViewAll = true,
    this.expandFlex = 0,
  });

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            prefix ?? SizedBox(),
            AppText(
              title,
              style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500),
            ),
            7.horizontalSpace,
            bonus ?? Container(),
            if (isViewAll) ...[
              Spacer(),
              AppText(
                context.text.viewAll,
                style: AppStyle.text14.copyWith(color: AppCustomColor.blue1F),
              ),
            ],
          ],
        ),
      ),
    );

    if (expandFlex > 0) {
      return Expanded(flex: expandFlex, child: titleWidget);
    }

    return titleWidget;
  }
}
