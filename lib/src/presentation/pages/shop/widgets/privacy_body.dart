part of '../shop.dart';

class PrivacyBody extends StatelessWidget {
  const PrivacyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.4 - MediaQuery.viewInsetsOf(context).bottom,
      child: Column(
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                20.horizontalSpace,
                AppText(
                  AppConfig.context!.text.privacy,
                  expandFlex: 1,
                  style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () => DNavigator.back(),
                  child: Icon(
                    FontAwesomeIcons.circleXmark,
                    size: 20.sp,
                    color: AppColorLight.onSurface,
                  ),
                )
              ],
            ),
          ),
          20.verticalSpace,
          // Danh sách Privacy
          BlocBuilder<ConfigCubit, ConfigState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: HtmlWidget(
                  state.privacyPolicy,
                  textStyle: AppStyle.text12,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
