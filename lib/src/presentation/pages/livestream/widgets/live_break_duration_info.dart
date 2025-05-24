part of '../livestream.dart';

class LiveBreakDurationInfo extends StatelessWidget {
  final String title;
  final String value;
  const LiveBreakDurationInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: AppCustomColor.greyD9,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(title, style: AppStyle.text16.copyWith(color: AppColorLight.shadow.op(0.4))),
            AppText(value),
          ],
        ),
      ),
    );
  }
}
