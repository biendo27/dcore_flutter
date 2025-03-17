part of '../wallet.dart';

class CustomButtonWallet extends StatelessWidget {
  const CustomButtonWallet({super.key, required this.title, required this.icon, required this.color, this.onPressed});
  final String title;
  final String icon;
  final Color color;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return DButton(
      size: Size(127.sp, 36.sp),
      padding: EdgeInsets.symmetric(horizontal: 12).w,
      margin: EdgeInsets.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      alignment: Alignment.centerLeft,
      backgroundColor: AppColorLight.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10).w),
      customChild: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 16.w,
            height: 16.h,
          ),
          12.horizontalSpace,
          AppText(
            title,
            style: AppStyle.text12.copyWith(color: color),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
