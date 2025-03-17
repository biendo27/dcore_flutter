part of '../../setting.dart';

class WithdrawCommissionSuccessPage extends StatefulWidget {
  const WithdrawCommissionSuccessPage({super.key});

  @override
  State<WithdrawCommissionSuccessPage> createState() => _WithdrawCommissionSuccessPageState();
}

class _WithdrawCommissionSuccessPageState extends State<WithdrawCommissionSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          24.verticalSpace,
          Image.asset(
            AppAsset.images.successGreen.path,
            width: 1.sw,
            height: 319.h,
          ),
          24.verticalSpace,
          AppText(
            context.text.confirmWithdrawSuccess,
            style: AppStyle.text16.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          20.verticalSpace,
          AppText(
            context.text.confirmWithdrawSuccessMessage,
            style: AppStyle.text14,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          20.verticalSpace,
          Spacer(),
          DButton(
            onPressed: () => DNavigator.pushReplacementNamed(
              RouteNamed.wallet,
            ),
            text: context.text.viewMyWallet,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ),
            style: AppStyle.text14.copyWith(
              color: AppColorLight.surface,
              fontWeight: FontWeight.w500,
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          30.verticalSpace,
        ],
      ),
    );
  }
}