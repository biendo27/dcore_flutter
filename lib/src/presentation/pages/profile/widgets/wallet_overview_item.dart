part of '../profile.dart';

class WalletOverviewItem extends StatelessWidget {
  const WalletOverviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16).w,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).w,
        gradient: LinearGradient(
          colors: AppCustomColor.gradientContainer,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  context.text.currentCoinNumber,
                  style: AppStyle.textBold16.copyWith(color: AppColorLight.surface),
                ),
                Row(
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        return AppText(
                          state.user.wallet.shortCurrency,
                          style: AppStyle.textBold24.copyWith(color: AppColorLight.surface),
                        );
                      },
                    ),
                    30.horizontalSpace,
                    DButton(
                      text: context.text.myWallet,
                      size: Size(100.w, 30.h),
                      padding: EdgeInsets.symmetric(horizontal: 12).w,
                      backgroundColor: AppColorLight.surface,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10).w),
                      customChild: Row(
                        children: [
                          AppText(
                            context.text.myWallet,
                            style: AppStyle.text14.copyWith(color: AppColorLight.primary),
                          ),
                          5.horizontalSpace,
                          Icon(
                            Icons.keyboard_double_arrow_right_rounded,
                            size: 20,
                            color: AppColorLight.primary,
                          ),
                        ],
                      ),
                      onPressed: () => DNavigator.goNamed(RouteNamed.wallet),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(AppAsset.images.coin.path, width: 56.w, height: 56.h),
        ],
      ),
    );
  }
}
