part of '../wallet.dart';

class RequestWithdrawalsPage extends StatefulWidget {
  const RequestWithdrawalsPage({super.key});

  @override
  State<RequestWithdrawalsPage> createState() => _RequestWithdrawalsPageState();
}

class _RequestWithdrawalsPageState extends State<RequestWithdrawalsPage> {
  Timer? _debounce;
  TextEditingController pointsToWithdraw = TextEditingController();
  TextEditingController bankUsed = TextEditingController();
  TextEditingController bankNumber = TextEditingController();
  TextEditingController bankOwner = TextEditingController();
  TextEditingController note = TextEditingController();

  void _onDebouncePointsToWithdraw(String value, BuildContext context) {
    debugPrint("value $value");
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<WalletCubit>().requestChangeCoinToMoney(int.parse(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubLayout(
        title: "Yêu cầu rút",
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.sp),
          child: Column(
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      AppText(context.text.pointsToWithdraw, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                      Spacer(),
                      BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
                        return DHighlightText(
                          text: "${context.text.amount}: ${state.coinToMoney.currencyVND}",
                          highlights: [state.coinToMoney.currencyVND],
                          highlightStyles: [AppStyle.text14.copyWith(color: AppCustomColor.redE2)],
                          style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                        );
                      })
                    ],
                  ),
                  8.verticalSpace,
                  DTextField(
                    hint: '500',
                    type: DTextInputType.number,
                    controller: pointsToWithdraw,
                    onChanged: (v) => _onDebouncePointsToWithdraw(v, context),
                  ),
                  AppText(context.text.bankUsed, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  8.verticalSpace,
                  DTextField(
                    hint: 'BIDV',
                    controller: bankUsed,
                  ),
                  AppText(context.text.bankAccountNumber, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  8.verticalSpace,
                  DTextField(
                    hint: '1234567',
                    controller: bankNumber,
                    type: DTextInputType.number,
                  ),
                  AppText(context.text.bankAccountHolder, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  8.verticalSpace,
                  DTextField(
                    hint: 'Nguyen Van Nam',
                    controller: bankOwner,
                  ),
                  AppText(context.text.additionalNotes, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                  8.verticalSpace,
                  DTextField(
                    hint: context.text.enterNote,
                    type: DTextInputType.multiline,
                    maxLines: 3,
                    controller: note,
                  ),
                ]),
              ),
              GradientButton(
                onPressed: () {
                  context.read<WalletCubit>().requestWithdraw(pointsToWithdraw.text, bankUsed.text, bankNumber.text, bankOwner.text, note.text);
                },
                text: context.text.requestWithdrawals,
              ),
            ],
          ),
        ));
  }
}
