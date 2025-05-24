part of '../shop.dart';

class ButtonSave extends StatelessWidget {
  const ButtonSave({
    super.key,
    this.onTap,
    required this.isSave,
  });
  final void Function()? onTap;
  final bool isSave;
  @override
  Widget build(BuildContext context) {
    return DButton(
      onPressed: onTap,
      text: context.text.saveForLater,
      size: Size(120.w, 35.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.w),
      backgroundColor: isSave ? AppCustomColor.greyDA : AppCustomColor.orangeF1,
      customChild: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isSave ? AppAsset.icons.voucherActive.path : AppAsset.icons.voucher.path,
            width: 20.w,
            fit: BoxFit.fitWidth,
          ),
          5.horizontalSpace,
          AppText(
            context.text.saveForLater,
            style: AppStyle.text14.copyWith(
              fontWeight: FontWeight.w500,
              color: isSave ? AppColorLight.onSurface.op(0.5) : AppColorLight.surface,
            ),
          ),
        ],
      ),
    );
  }
}
