part of '../shop.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({
    super.key,
    required this.title,
    this.onTap,
  });
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    Widget tmp = Container(
      width: 66.w,
      height: 23.h,
      margin: EdgeInsets.only(right: 7.w),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppCustomColor.greyF5,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: AppText(title, style: AppStyle.text10.copyWith(fontWeight: FontWeight.w500)),
    );

    if (onTap != null) {
      tmp = InkWell(
        onTap: onTap,
        child: tmp,
      );
    }
    return tmp;
  }
}
