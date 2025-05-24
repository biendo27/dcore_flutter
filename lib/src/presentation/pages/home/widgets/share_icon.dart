part of '../home.dart';

class ShareIcon extends StatelessWidget {
  final String imagePath;
  final String label;
  const ShareIcon({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 45.w, height: 45.h),
        10.verticalSpace,
        AppText(label, style: AppStyle.text10),
      ],
    );
  }
}