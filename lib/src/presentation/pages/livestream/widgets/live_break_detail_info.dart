part of '../livestream.dart';

class LiveBreakDetailInfo extends StatelessWidget {
  final LiveRequest breakSchedule;
  const LiveBreakDetailInfo({super.key, required this.breakSchedule});

  Color get background {
    return switch (breakSchedule.status) {
      BreakScheduleStatus.pending => AppCustomColor.orangeF1,
      BreakScheduleStatus.approved => AppCustomColor.green0F,
      BreakScheduleStatus.rejected => AppCustomColor.redD0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(breakSchedule.status.name, style: AppStyle.text16.copyWith(color: AppColorLight.surface)),
          AppText(breakSchedule.endAt?.dateTimeString ?? '', style: AppStyle.text16.copyWith(color: AppColorLight.surface)),
        ],
      ),
    );
  }
}
