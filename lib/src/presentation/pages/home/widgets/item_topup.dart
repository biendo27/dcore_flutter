part of '../home.dart';

class ItemTopUp extends StatelessWidget {
  const ItemTopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 25.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppCustomColor.orangeF1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAsset.images.coin.path, width: 15.w, height: 15.h),
              5.horizontalSpace,
              AppText('16', style: AppStyle.textBold16),
              5.horizontalSpace,
              AppText(
                '+ 16',
                style: AppStyle.textBold16.copyWith(color: AppCustomColor.orangeF1),
              ),
            ],
          ),
          7.verticalSpace,
          AppText(' 100.000đ', style: AppStyle.text10.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
