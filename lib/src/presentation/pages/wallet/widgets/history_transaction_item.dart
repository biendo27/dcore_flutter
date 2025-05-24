part of '../wallet.dart';

class HistoryTransactionItem extends StatelessWidget {
  final String title;
  final String status;
  final String date;
  final bool success;

  const HistoryTransactionItem({
    super.key,
    this.title = '',
    this.status = '',
    this.date = '',
    this.success = false,
  });

  IconData get icon => success ? Icons.arrow_circle_up_rounded : Icons.arrow_circle_down_rounded;
  Color get color => success ? AppCustomColor.green05 : AppCustomColor.orangeFF;

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
              AppText(status, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500, color: color)),
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
