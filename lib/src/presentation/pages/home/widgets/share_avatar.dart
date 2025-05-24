part of '../home.dart';

class ShareAvatar extends StatelessWidget {
  final String imagePath;
  final String title;
  final Widget? icon;
  const ShareAvatar({super.key, required this.imagePath, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 20.r,
            ),
          ),
          14.verticalSpace,
          AppText(
            title,
            style: AppStyle.text10.copyWith(color: AppColorLight.onSurface),
          ),
        ],
      ),
      Positioned(
        left: 10.w,
        right: 10.w,
        top: 30.h,
        child: icon ?? Container(),
      ),
    ]);
  }
}
