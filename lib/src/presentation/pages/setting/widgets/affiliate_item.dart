part of '../setting.dart';

class AffiliateItem extends StatelessWidget {
  const AffiliateItem({
    super.key,
    required this.title,
    required this.status,
    required this.date,
    this.success = false,
    this.pending = false,
    this.canceled = false,
  });
  final String title;
  final String status;
  final String date;
  final bool success;
  final bool pending;
  final bool canceled;

  IconData get icon {
    return Icons.arrow_circle_up_rounded;
  }

  String get text {
    if (success) {
      return AppConfig.context!.text.successTitle;
    } else if (canceled) {
      return AppConfig.context!.text.cancelTitle;
    } else {
      return AppConfig.context!.text.pendingTitle;
    }
  }

  Color get color {
    if (success) {
      return AppCustomColor.green05;
    } else if (canceled) {
      return AppCustomColor.redD0;
    } else {
      return AppCustomColor.orangeFF;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorLight.surface,
        boxShadow: [
          BoxShadow(
            color: AppColorLight.shadow.op(0.1),
            blurRadius: 7,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(10.sp),
      ),
      padding: EdgeInsets.all(10.86.sp),
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            children: [
              AppText(title, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
              Spacer(),
              AppText(text, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500, color: color)),
            ],
          ),
          4.verticalSpace,
          Row(
            children: [
              AppText(date, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w300, color: AppCustomColor.greyAC)),
              Spacer(),
              Icon(
                icon,
                size: 16.29.w,
                color: color,
              ),
              4.horizontalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
