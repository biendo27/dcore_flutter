part of '../wallet.dart';

class AddCoin extends StatefulWidget {
  const AddCoin({super.key});

  @override
  State<AddCoin> createState() => _AddCoinState();
}

class _AddCoinState extends State<AddCoin> {
  late Package packageSelect;

  @override
  void initState() {
    packageSelect = context.read<WalletCubit>().state.packages[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.75),
        _background(),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    16.horizontalSpace,
                    Image.asset(
                      AppAsset.images.coin.path,
                      width: 35.sp,
                      height: 35.sp,
                    ),
                    16.horizontalSpace,
                    AppText(
                      context.text.topUpCoin,
                      style: AppStyle.text16.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                15.verticalSpace,
                Container(
                  padding: EdgeInsets.all(20.sp),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp), border: Border.all(color: AppCustomColor.orangeFF, width: 0.5), color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        AppAsset.images.dollar.path,
                        width: 55.sp,
                        height: 55.sp,
                        fit: BoxFit.cover,
                      ),
                      20.horizontalSpace,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${context.text.receive} ",
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16.sp),
                                ),
                                TextSpan(
                                  text: "${context.text.coinReward} ",
                                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppCustomColor.orangeFF),
                                ),
                                TextSpan(
                                  text: "${context.text.add} ",
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                          AppText(
                            context.text.useCoinToBuy,
                            style: AppStyle.text13,
                            maxLines: 2,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                15.verticalSpace,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${context.text.receive} ",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: context.text.coin,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppCustomColor.orangeFF),
                      ),
                    ],
                  ),
                ),
                15.verticalSpace,
                Expanded(
                  child: BlocBuilder<WalletCubit, WalletState>(
                    builder: (context, state) {
                      List<Package> packages = state.packages;
                      bool firstDeposit = state.firstDeposit;
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15.sp,
                          crossAxisSpacing: 15.sp,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: packages.length,
                        itemBuilder: (context, index) {
                          final package = packages[index];
                          return CoinItem(
                            package: package,
                            firstDeposit: firstDeposit,
                            packageSelect: packageSelect,
                            onTap: (package) {
                              packageSelect = package;
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                20.verticalSpace,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Đồng ý với ",
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                      TextSpan(
                        text: "chính sách vật phẩm ảo",
                        style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
                GradientButton(
                  onPressed: () {
                    DNavigator.back();
                    DNavigator.goNamed(RouteNamed.paymentMethod, extra: packageSelect);
                  },
                  customChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        context.text.buy,
                        style: AppStyle.text16.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                      ),
                      4.horizontalSpace,
                      Image.asset(
                        AppAsset.images.dollar.path,
                        width: 24.sp,
                        height: 24.sp,
                      ),
                      4.horizontalSpace,
                      AppText(
                        "${packageSelect.coin} xu (${packageSelect.price.currencyVND})",
                        style: AppStyle.text16.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _background() {
    return Container(
      height: 80.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE35524).op(0.3),
            Colors.white,
          ],
        ),
      ),
    );
  }
}
