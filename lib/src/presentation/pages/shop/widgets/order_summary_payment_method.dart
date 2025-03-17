part of '../shop.dart';

class OrderSummaryPaymentMethod extends StatelessWidget {
  final ValueNotifier<int> selectedPaymentMethod;
  const OrderSummaryPaymentMethod({super.key, required this.selectedPaymentMethod});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderPaymentMethodCubit, OrderPaymentMethodState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r), // Bo góc
            border: Border.all(
              color: Colors.grey.shade300, // Màu viền
              width: 1, // Độ dày viền
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.op(0.05), // Đổ bóng nhẹ
                blurRadius: 4,
                spreadRadius: 1,
                offset: Offset(0, 2), // Bóng đổ xuống dưới
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppAsset.svg.walletCard, width: 14.w, height: 14.w),
                  4.horizontalSpace,
                  AppText(
                    context.text.paymentMethod,
                    style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              ...List.generate(
                state.paymentMethods.length,
                (index) => MethodPaymentItem(
                  selectedValue: selectedPaymentMethod,
                  methodId: state.paymentMethods[index].id,
                  image: state.paymentMethods[index].image,
                  title: state.paymentMethods[index].name,
                  onChange: (value) {
                    selectedPaymentMethod.value = value ?? 0;
                    PaymentMethod paymentMethod = state.paymentMethods[index];
                    context.read<OrderCubit>()
                      ..setPaymentMethod(paymentMethod)
                      ..updateOrderInfo();
                  },
                ),
              ),
              30.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
