part of '../../shop.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage({super.key});

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  bool isSwitched = false;
  int selectedValue = -1;

  List<TextEditingController> noteControllers = [];
  ValueNotifier<bool> isUseCoin = ValueNotifier(false);
  ValueNotifier<Voucher> selectedShippingVoucher = ValueNotifier(Voucher());
  ValueNotifier<Voucher> selectedOtherVoucher = ValueNotifier(Voucher());
  ValueNotifier<bool> noUseVoucherCode = ValueNotifier(false);
  ValueNotifier<int> selectedPaymentMethod = ValueNotifier(1);

  @override
  void initState() {
    _initControllers(context.read<OrderCubit>().state.orderOverviewInfo);
    _initListeners();
    super.initState();
  }

  void _initListeners() {
    selectedOtherVoucher.addListener(() {
      if (selectedOtherVoucher.value.id != 0) noUseVoucherCode.value = false;
    });
    selectedShippingVoucher.addListener(() {
      if (selectedShippingVoucher.value.id != 0) noUseVoucherCode.value = false;
    });
  }

  void _initControllers(OrderOverviewInfo orderOverviewInfo) {
    for (var i = 0; i < orderOverviewInfo.stores.length; i++) {
      noteControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return SubLayout(
          title: context.text.orderSummary,
          isLoading: state.isLoading,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<DeliveryAddressCubit, DeliveryAddressState>(
                        builder: (context, state) {
                          return DefaultDeliveryAddressItem(addressData: state.defaultAddress);
                        },
                      ),
                      ...List.generate(
                        state.orderOverviewInfo.stores.length,
                        (index) => OrderSummaryShopProductInfo(
                          storeInfo: state.orderOverviewInfo.stores[index],
                          controller: noteControllers[index],
                        ),
                      ),
                      OrderSummaryVoucherAndCoinInfo(
                        orderOverviewInfo: state.orderOverviewInfo,
                        isUseCoin: isUseCoin,
                        selectedShippingVoucher: selectedShippingVoucher,
                        selectedOtherVoucher: selectedOtherVoucher,
                        noUseVoucherCode: noUseVoucherCode,
                      ),
                      OrderSummaryInfo(orderOverviewInfo: state.orderOverviewInfo),
                      OrderSummaryPaymentMethod(selectedPaymentMethod: selectedPaymentMethod),
                      AppText(
                        context.text.orderAgreement,
                        style: AppStyle.text14,
                        maxLines: 5,
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppText(
                          "${context.text.totalQuantity}: ${state.orderOverviewInfo.totalQuantity}",
                          style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText(
                              state.orderOverviewInfo.totalMoney.currencyVND,
                              style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500),
                            ),
                            AppText(
                              "${context.text.saveMoney}: ${state.orderOverviewInfo.saveMoney.currencyVND}",
                              style: AppStyle.text12.copyWith(color: AppCustomColor.redD0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    10.verticalSpace,
                   Container(
                     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                     child:  GradientButton(

                       text: context.text.payNow,
                       onPressed: () => context.read<OrderCubit>().createOrder(),
                       style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                     ),
                   )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
