part of '../shop.dart';


class OrderItemAction extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final int expandFlex;
  final bool isSecondary;
  const OrderItemAction({
    super.key,
    this.title = '',
    required this.onTap,
    this.expandFlex = 0,
    this.isSecondary = true,
  });

  @override
  Widget build(BuildContext context) {
    return DButton(
      onPressed: onTap,
      text: title,
      expandedFlex: expandFlex,
      style: AppStyle.text14.copyWith(color: isSecondary ? AppColorLight.onSurface : AppColorLight.onPrimary, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: isSecondary ? AppCustomColor.greyF5 : AppCustomColor.orangeF1,
    );
  }
}
