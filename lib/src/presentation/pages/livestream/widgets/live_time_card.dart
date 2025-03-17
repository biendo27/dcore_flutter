part of '../livestream.dart';

class LiveTimeCard extends StatelessWidget {
  final String title;
  final String time;
  const LiveTimeCard({
    super.key,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 155.w,
      decoration: BoxDecoration(
        color: AppCustomColor.greyD9,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(title, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.onSurface.op(0.4))),
          10.horizontalSpace,
          AppText(time, style: AppStyle.text24.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
