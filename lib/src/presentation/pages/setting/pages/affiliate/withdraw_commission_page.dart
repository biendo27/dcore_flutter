part of '../../setting.dart';

class WithdrawCommissionPage extends StatefulWidget {
  const WithdrawCommissionPage({super.key});

  @override
  State<WithdrawCommissionPage> createState() => _WithdrawCommissionPageState();
}

class _WithdrawCommissionPageState extends State<WithdrawCommissionPage> {

  @override
  void initState() {
    final cubit = context.read<AffiliateCubit>();
    cubit.affiliateMoneyToCoin(cubit.state.totalCommission);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.confirmWithdraw,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: LinearGradient(
                        begin: Alignment(-1.0, -1.0),
                        end: Alignment(1.0, 1.0),
                        colors: AppCustomColor.gradientContainer,
                        stops: [0.0, 0.3, 0.71, 1.0],
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AppAsset.images.coin.path, width: 37.5.w, height: 37.5.w),
                        16.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              context.text.myWallet,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600, color: AppColorLight.surface),
                            ),
                            3.verticalSpace,
                            AppText(context.text.withdrawToEwallet, style: AppStyle.text12.copyWith(color: AppColorLight.surface)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                AppText(context.text.amount, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                Spacer(),
                AppText("${context.text.coinNumber}: ", style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                BlocBuilder<AffiliateCubit, AffiliateState>(
                  builder: (context, state) {
                    return AppText(state.coinToMoney.currencyVND, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.redD0));
                  }
                ),
              ],
            ),
            20.verticalSpace,
            BlocBuilder<AffiliateCubit, AffiliateState>(
                builder: (context, state) {
                return AppText(
                  state.totalCommission.currency,
                  style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500),
                  margin: EdgeInsets.only(left: 14.w),
                );
              }
            ),
            20.verticalSpace,
            BlocBuilder<AffiliateCubit, AffiliateState>(
                builder: (context, state) {
                return GradientButton(
                  onPressed: () {
                    context.read<AffiliateCubit>().affiliateWithdraw(state.totalCommission);
                  },
                  text: context.text.confirm,
                );
              }
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
