part of '../livestream.dart';

class DutyItem extends StatelessWidget {
  final LiveMission missionData;
  const DutyItem({
    super.key,
    required this.missionData,
  });

  bool get isMissionComplete => missionData.isReceive || missionData.progress >= missionData.quantity;

  String buttonText(BuildContext context) {
    if (missionData.isReceive) {
      return context.text.received;
    }

    if (missionData.progress < missionData.quantity) {
      return '${missionData.progress}/${missionData.quantity}';
    }

    return context.text.receive;
  }

  Color get buttonColor {
    if (missionData.progress >= missionData.quantity && !missionData.isReceive) {
      return AppCustomColor.orangeF5;
    }

    return AppCustomColor.greyDA.op(0.5);
  }

  String missionGiftText(BuildContext context) {
    return switch (missionData.type) {
      LiveGiftType.coin => '${missionData.coin} ${context.text.coin}',
      LiveGiftType.voucher => '${context.text.voucher} ${missionData.voucher.displayTitle(context)}',
      LiveGiftType.product => missionData.product.name,
      LiveGiftType.wheel => '${missionData.wheel} ${context.text.spinWheel}',
    };
  }

  void _onMissionTap(BuildContext context) async {
    if (!isMissionComplete) return;

    context.read<LiveMissionCubit>().receiveMission(missionData.id);

    DNavigator.back();
    // } else {

    //  }
  }

  Widget _buildButton(BuildContext context) {
    return DButton(
      onPressed: () => _onMissionTap(context),
      text: buttonText(context),
      customChild: isMissionComplete
          ? null
          : DHighlightText(
              text: buttonText(context),
              highlights: ['${missionData.progress}'],
              style: AppStyle.textBold14.copyWith(color: AppColorLight.surface),
              highlightStyles: [AppStyle.textBold14.copyWith(color: AppColorLight.primary)],
            ),
      size: Size(95.w, 30.h),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5).w,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.sp))),
      style: AppStyle.text14.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
      backgroundColor: buttonColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppCustomColor.orangeF5, width: 0.1.sp),
        borderRadius: BorderRadius.circular(5.sp),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DCachedImage(
                      url: missionData.mission.image,
                      width: 20.sp,
                    ),
                    5.horizontalSpace,
                    AppText(
                      missionGiftText(context),
                      expandFlex: 1,
                      maxLines: 2,
                      style: AppStyle.text14.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                5.verticalSpace,
                AppText(
                  missionData.note,
                  style: AppStyle.text12.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          _buildButton(context),
        ],
      ),
    );
  }
}
