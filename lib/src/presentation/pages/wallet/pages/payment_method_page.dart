part of '../wallet.dart';

class PaymentMethodPage extends StatefulWidget {
  final Package package;
  const PaymentMethodPage({super.key, required this.package});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  // final List<PaymentModule> listPayment = [
  //   PaymentModule(Assets.vnPay, "VNPAY", "Thẻ ATM/Visa/Master/QR"),
  //   PaymentModule(Assets.banking, "Chuyển khoản", "Qua tài khoản Internet Banking"),
  //   PaymentModule(Assets.applePay, "Apple Pay", "Thanh toán sử dụng ví Apple Pay"),
  //   PaymentModule(Assets.googlePay, "Google Pay", "Thanh toán sử dụng ví Google Pay"),
  // ];

  late PaymentMethod paymentMethodSelected;

  @override
  void initState() {
    paymentMethodSelected = context.read<WalletCubit>().state.paymentMethods[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.payment,
      backgroundColor: Color(0xffF3F3F3),
      isLoading: context.select((InAppCubit cubit) => cubit.state.isLoading),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  List<PaymentMethod> payments = state.appPaymentMethods;
                  return ListView.builder(
                      itemCount: payments.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        PaymentMethod payment = payments[index];
                        return PaymentWidget(
                          data: payment,
                          paymentMethodSelected: paymentMethodSelected,
                          onTap: () {
                            paymentMethodSelected = payment;
                            setState(() {});
                          },
                        );
                      });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 20.sp),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.sp)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(context.text.package, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600)),
                  AppText(context.text.coinPrice(widget.package.coin, widget.package.price.currencyVND), style: AppStyle.text14.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
            ),
            100.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(context.text.totalAmount, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600)),
                AppText(widget.package.price.currencyVND, style: AppStyle.text14.copyWith(fontWeight: FontWeight.bold, color: Color(0xffE4002B)))
              ],
            ),
            20.verticalSpace,
            GradientButton(
              onPressed: _handlePayment,
              text: context.text.payment,
            )
          ],
        ),
      ),
    );
  }

  void _handlePayment() {
    switch (paymentMethodSelected.id) {
      case 2:
        context.read<WalletCubit>().walletDeposit(
          widget.package.id,
          paymentMethodSelected.id,
          callback: (id) {
            context.read<WalletCubit>().walletCreatePaymentVNPayTransaction(id, callback: (url) {
              DNavigator.goNamed(RouteNamed.vnpayWebView, extra: url);
            });
          },
        );
        break;
      case 3:
        context.read<WalletCubit>().walletDeposit(widget.package.id, paymentMethodSelected.id, callback: (id) {
          DNavigator.goNamed(RouteNamed.paymentConfirm, extra: id);
        });
        break;
      case 4:
      case 5:
        context.read<InAppCubit>().purchaseProduct(
              widget.package.inAppId,
              PurchaseType.consumable,
            );
        break;
      default:
        DMessage.showMessage(message: "Không hỗ trợ phương thức thanh toán này", type: MessageType.error);
    }
  }
}

class PaymentModule {
  final String icon;
  final String paymentType;
  final String describe;

  PaymentModule(this.icon, this.paymentType, this.describe);
}
