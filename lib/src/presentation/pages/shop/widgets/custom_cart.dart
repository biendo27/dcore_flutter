part of '../shop.dart';

class CustomCart extends StatelessWidget {
  final int number;
  final EdgeInsets? padding;
  final void Function()? onTap;

  const CustomCart({
    super.key,
    required this.number,
    this.onTap,
    this.padding,
  });

  String get badgeLabel => number > 9 ? '9+' : number.toString();

  @override
  Widget build(BuildContext context) {
    Widget tmp = Container(
      margin: padding ?? EdgeInsets.only(right: 10.w),
      child: Badge(
        label: AppText(badgeLabel, style: AppStyle.text8.copyWith(color: AppColorLight.surface)),
        padding: EdgeInsets.zero,
        textStyle: AppStyle.text8,
        backgroundColor: AppCustomColor.redF5,
        isLabelVisible: number > 0,
        child: Image.asset(AppAsset.images.carts.path, height: 25.w, width: 25.w, fit: BoxFit.cover),
      ),
    );

    if (onTap != null) {
      tmp = GestureDetector(
        onTap: onTap,
        child: tmp,
      );
    }
    return tmp;
  }
}
