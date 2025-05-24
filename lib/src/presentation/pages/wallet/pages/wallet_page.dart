part of '../wallet.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    context.read<WalletCubit>()
      ..fetchWallet(page)
      ..walletPolicy()
      ..walletPaymentMethod()
      ..walletPackage();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent
          && context.read<WalletCubit>().state.listTransaction.length%10==0){
        page = page + 1;
        context.read<WalletCubit>().fetchWallet(page);
      }});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.myWallet,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserWalletInfoCardPage(),
            20.verticalSpace,
            AppText(
              context.text.historyTransaction,
              style: AppStyle.text16.copyWith(fontWeight: FontWeight.w600),
            ),
            20.verticalSpace,
            Expanded(
              child: BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  List<Transaction> data = state.listTransaction;
                  return ListView.builder(
                    itemCount: data.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final bool isSuccess = data[index].status.contains(context.text.successTitle);
                      return InkWell(
                        onTap: () {
                          DNavigator.goNamed(RouteNamed.transactionDetails, extra: data[index].id);
                        },
                        child: HistoryTransactionItem(
                          title: data[index].classification,
                          status: data[index].status,
                          date: data[index].createdAt!.dateTimeString,
                          success: isSuccess,
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

