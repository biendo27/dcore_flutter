part of '../wallet.dart';

class UserWalletInfoCardPage extends StatefulWidget {
  const UserWalletInfoCardPage({super.key});

  @override
  State<UserWalletInfoCardPage> createState() => _UserWalletInfoCardPageState();
}

class _UserWalletInfoCardPageState extends State<UserWalletInfoCardPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.sp),
          child: Image.asset(
            AppAsset.images.walletBackground.path,
            width: MediaQuery.of(context).size.width,
            height: 159.sp,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 56.h),
          child:  Divider(height: 1.h, color: Colors.white),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppAsset.images.coin.path,
                      width: 24.sp,
                      height: 24.sp,
                    ),
                    16.horizontalSpace,
                    AppText(
                      context.text.myWallet,
                      style: AppStyle.text16.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                30.verticalSpace,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppText(
                            context.text.currentCoinNumber,
                            style: AppStyle.text16.copyWith(fontWeight: FontWeight.w300, color: AppColorLight.surface),
                          ),
                          BlocBuilder<WalletCubit, WalletState>(
                            builder: (context, state) {
                              return AppText(
                                state.walletCoin.shortCurrency,
                                style: AppStyle.text24.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                              );
                            }
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButtonWallet(
                            icon: AppAsset.svg.arrowDown,
                            title: context.text.topUpCoin,
                            color: AppCustomColor.green05,
                            onPressed: () {
                              // DNavigator.goNamed(RouteNamed.depositDetails);
                              showDModalBottomSheet(
                                contentPadding: EdgeInsets.zero,
                                maxChildSize: 0.75,
                                enableDrag: false,
                                initialChildSize: 0.75,
                                bodyWidget: AddCoin(),
                              );
                            },
                          ),
                          CustomButtonWallet(
                            icon: AppAsset.svg.arrowUp,
                            title: context.text.withdrawalRequest,
                            color: AppCustomColor.redE2,
                            onPressed: () {
                              DNavigator.goNamed(RouteNamed.requestWithdrawals);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
