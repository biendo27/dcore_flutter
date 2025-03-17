part of '../setting.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({super.key, required this.icon, required this.title, required this.navigationIcon, this.onTap});
  final String icon;
  final String title;
  final IconData? navigationIcon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.sp),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 15.w,
            ),
            18.horizontalSpace,
            AppText(title),
            Spacer(),
            if (navigationIcon != null)
              Icon(
                navigationIcon,
                size: 15.sp,
              )
          ],
        ),
      ),
    );
  }
}
