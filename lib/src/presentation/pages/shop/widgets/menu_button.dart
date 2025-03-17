part of '../shop.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.onReset,
    required this.onApply,
  });
  final void Function() onReset;
  final void Function() onApply;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          DButton(
            expandedFlex: 1,
            text: context.text.reset,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            textColor: AppColorLight.onSurface,
            style: AppStyle.text14.copyWith(fontWeight: FontWeight.w400),
            backgroundColor: AppCustomColor.greyF5,
            onPressed: onReset,
          ),
          12.horizontalSpace,
          DButton(
            expandedFlex: 1,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            text: context.text.apply,
            style: AppStyle.text14.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColorLight.surface,
            ),
            onPressed: onApply,
          ),
        ],
      ),
    );
  }
}
