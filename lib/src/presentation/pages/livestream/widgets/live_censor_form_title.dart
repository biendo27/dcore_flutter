part of '../livestream.dart';

class LiveCensorFormTitle extends StatelessWidget {
  final String title;
  const LiveCensorFormTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppCustomColor.orangeF6,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.bookmark_added_rounded, color: AppColorLight.onPrimary),
          10.horizontalSpace,
          AppText(
            title,
            style: AppStyle.textBold16.copyWith(color: AppColorLight.onPrimary),
            maxLines: 3,
            expandFlex: 1,
          ),
        ],
      ),
    );
  }
}
