part of '../shop.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool isActive;

  const CustomPopupMenuButton({
    super.key,
    required this.title,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget tmp = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive ? AppCustomColor.orangeF1 : AppCustomColor.greyF5,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          5.horizontalSpace,
          AppText(
            title,
            style: AppStyle.text12.copyWith(fontWeight: FontWeight.w300, color: isActive ? AppColorLight.onPrimary : AppColorLight.onSurface),
          ),
          4.horizontalSpace,
          Icon(Icons.keyboard_arrow_down, size: 15.sp, color: isActive ? AppColorLight.onPrimary : AppColorLight.onSurface),
        ],
      ),
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
