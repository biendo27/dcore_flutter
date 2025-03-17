part of '../../shop.dart';

class ShopPaymentMethodPage extends StatefulWidget {
  const ShopPaymentMethodPage({super.key});

  @override
  State<ShopPaymentMethodPage> createState() => _ShopPaymentMethodPageState();
}

class _ShopPaymentMethodPageState extends State<ShopPaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.paymentMethod,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                context.read<RefundBankingCubit>()
                  ..reset()
                  ..fetchRefundBanking()
                  ..fetchRefundBankingListBankData();
                DNavigator.goNamed(RouteNamed.bankAccountRefund);
              },
              child: Row(
                children: [
                  SvgPicture.asset(AppAsset.svg.walletCard, width: 40.w),
                  18.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        context.text.bankAccountRefund,
                        style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600),
                      ),
                      AppText(
                        context.text.refundPurchase,
                        style: AppStyle.text14.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppCustomColor.black2D.op(0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
