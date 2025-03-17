part of '../livestream.dart';

class LivestreamViewItem extends StatelessWidget {
  final Comment comment;

  const LivestreamViewItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DCachedImage(
            url: comment.user.image,
            width: 30.w,
            height: 30.w,
            borderRadius: BorderRadius.circular(15.r),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  comment.user.name,
                  style: AppStyle.textBold12.copyWith(color: AppColorLight.onPrimary),
                  maxLines: 1,
                ),
                5.verticalSpace,
                AppText(
                  comment.content,
                  style: AppStyle.text12.copyWith(color: AppColorLight.onPrimary, fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
