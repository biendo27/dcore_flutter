part of '../home.dart';

class VirtualItemPolicyBody extends StatelessWidget {
  const VirtualItemPolicyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 56.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppCustomColor.greyF5,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: AppText(
            AppConfig.context!.text.virtualItemPolicy,
            style: AppStyle.text14.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
          ),
        ),
        20.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              AppText("Chính sách 1"),
              10.verticalSpace,
              AppText("Chính sách 2"),
              10.verticalSpace,
              AppText("Chính sách 3"),
              10.verticalSpace,
              AppText("Chính sách 4"),
            ],
          ),
        )
      ],
    );
  }
}
