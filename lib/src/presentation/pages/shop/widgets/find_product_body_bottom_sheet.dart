part of '../shop.dart';

class FindProductBodyBottomSheet extends StatelessWidget {
  final String title;
  final Widget filterWidget;
  final void Function()? onApply;
  final void Function()? onReset;

  const FindProductBodyBottomSheet({
    super.key,
    required this.title,
    required this.filterWidget,
    this.onApply,
    this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.28 - MediaQuery.viewInsetsOf(context).bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  title,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: filterWidget,
          ),
          16.verticalSpace,
          MenuButton(
            onApply: onApply ?? () {},
            onReset: onReset ?? () {},
          ),
          15.verticalSpace,
        ],
      ),
    );
  }
}
