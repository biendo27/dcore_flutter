part of '../wallet.dart';

class TransactionDetailsPage extends StatefulWidget {
  final int id;
  const TransactionDetailsPage({super.key, required this.id});

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  @override
  void initState() {
    context.read<WalletCubit>().fetchWalletDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
        title: context.text.detailTransaction,
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
                final transaction = state.transaction;
                if (transaction.classification.contains("Nạp tiền")) {
                  return _widgetDeposit(transaction);
                }

                return _widgetWithdrawals(transaction);
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
              child: DButton(
                onPressed: () {
                  DNavigator.goNamed(RouteNamed.contact);
                },
                text: context.text.contact,
                backgroundColor: AppCustomColor.greyF5,
                textColor: Colors.black,
              ),
            )
          ],
        ));
  }

  Widget _widgetDeposit(Transaction transaction) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          DTitleAndText(
            title: context.text.trancastionCode,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.code,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.perform,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.createdAt!.dateTimeString,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.transactionType,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.classification,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.blue17),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.depositAmount,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.money.currencyVND,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.numberOfCoinsReceived,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: '${transaction.coin} ${context.text.coin.toLowerCase()}',
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.rechargeForm,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.paymentMethod,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.blue17),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.status,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.status,
            textStyle: AppStyle.text14
                .copyWith(fontWeight: FontWeight.w500, color: transaction.status.contains(context.text.successTitle) ? AppCustomColor.green05 : AppCustomColor.orangeFF),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.transactionImage,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: '',
          ),
          15.verticalSpace,
          DCachedImage(url: transaction.image, height: 280.sp, width: 200.sp, fit: BoxFit.contain)
        ],
      ),
    );
  }

  Widget _widgetWithdrawals(Transaction transaction) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          DTitleAndText(
            title: context.text.trancastionCode,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.code,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.perform,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.createdAt?.dateTimeString ?? '',
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.transactionType,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.classification,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppCustomColor.blue17),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.convertedAmount,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.money.currencyVND,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.withdrawnCoins,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: '${transaction.coin} ${context.text.coin.toLowerCase()}',
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.bankUsed,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.bankName,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.bankAccountNumber,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.bankNumber,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.bankAccountHolder,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.bankOwner,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.note,
            titleMaxLines: 10,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.note,
            textMaxLines: 10,
            textStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w300),
          ),
          15.verticalSpace,
          DTitleAndText(
            title: context.text.status,
            titleStyle: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
            text: transaction.status,
            textStyle: AppStyle.text14
                .copyWith(fontWeight: FontWeight.w500, color: transaction.status.contains(context.text.successTitle) ? AppCustomColor.green05 : AppCustomColor.orangeFF),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    AppConfig.context!.read<WalletCubit>().clearTransaction();
    super.dispose();
  }
}
