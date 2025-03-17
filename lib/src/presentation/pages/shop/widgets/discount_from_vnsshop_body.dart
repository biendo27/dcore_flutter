part of '../shop.dart';

class DiscountFromVnsShopBody extends StatelessWidget {
  final String title;
  final ValueNotifier<Voucher> selectedShippingVoucher;
  final ValueNotifier<Voucher> selectedOtherVoucher;
  final ValueNotifier<bool> noUseVoucherCode;
  final TextEditingController _codeController = TextEditingController();

  DiscountFromVnsShopBody({
    super.key,
    required this.title,
    required this.selectedShippingVoucher,
    required this.selectedOtherVoucher,
    required this.noUseVoucherCode,
  });

  ValueNotifier<Voucher> getOrderVoucherResult(VoucherClassification classification) {
    if (classification == VoucherClassification.price) return selectedOtherVoucher;
    return selectedShippingVoucher;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.9 - MediaQuery.viewInsetsOf(context).bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppCustomColor.greyF5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                20.horizontalSpace,
                AppText(
                  title,
                  expandFlex: 1,
                  style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () => DNavigator.back(),
                  child: Icon(
                    FontAwesomeIcons.circleXmark,
                    size: 20.sp,
                    color: AppColorLight.onSurface,
                  ),
                )
              ],
            ),
          ),
          24.verticalSpace,
          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const AppLoading();
              }

              if (state.orderShippingVouchers.data.isEmpty && state.orderVouchers.data.isEmpty) {
                return NoData();
              }

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      context.text.enterDiscountCode,
                      style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                    ),
                    4.verticalSpace,
                    DTextField(
                      hint: context.text.enterDiscountCode,
                      onChanged: (value) {
                        if (value.isNotEmpty) return;
                        selectedOtherVoucher.value = Voucher();
                        selectedShippingVoucher.value = Voucher();
                        context.read<OrderCubit>()
                          ..clearOrderVoucherResult()
                          ..getOrderVouchers(isInit: true)
                          ..getOrderShippingVouchers(isInit: true);
                      },
                      controller: _codeController,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: AppCustomColor.greyF2)),
                      hintStyle: AppStyle.text14.copyWith(color: AppCustomColor.greyAC),
                      suffix: DButton(
                        onPressed: () {
                          selectedOtherVoucher.value = Voucher();
                          selectedShippingVoucher.value = Voucher();
                          context.read<OrderCubit>().getVoucherByCode(_codeController.text);
                        },
                        size: Size(85.w, 40.h),
                        text: context.text.apply,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.r),
                            bottomRight: Radius.circular(100.r),
                          ),
                        ),
                        style: AppStyle.text14.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (state.orderVoucherResult.id != 0) ...[
                      DiscountItem(
                        voucher: state.orderVoucherResult,
                        selectedVoucherNotifier: getOrderVoucherResult(VoucherClassification.price),
                      )
                    ],
                    if (state.orderShippingVouchers.data.isNotEmpty && state.orderVoucherResult.id == 0) ...[
                      AppText(
                        context.text.shippingVoucher,
                        style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                      ),
                      10.verticalSpace,
                      ...List.generate(state.orderShippingVouchers.data.length, (index) {
                        return DiscountItem(
                          voucher: state.orderShippingVouchers.data[index],
                          selectedVoucherNotifier: selectedShippingVoucher,
                        );
                      }),
                      if (!state.orderShippingVouchers.isLastPage)
                        Center(
                          child: DIconText(
                            onTap: () => context.read<OrderCubit>().getOrderShippingVouchers(),
                            iconPosition: IconPosition.end,
                            icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
                            text: context.text.viewAll,
                          ),
                        ),
                    ],
                    if (state.orderVouchers.data.isNotEmpty && state.orderVoucherResult.id == 0) ...[
                      AppText(
                        context.text.otherVoucher,
                        style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                      ),
                      10.verticalSpace,
                      ...List.generate(state.orderVouchers.data.length, (index) {
                        return DiscountItem(
                          voucher: state.orderVouchers.data[index],
                          selectedVoucherNotifier: selectedOtherVoucher,
                        );
                      }),
                      if (!state.orderVouchers.isLastPage)
                        Center(
                          child: DIconText(
                            onTap: () => context.read<OrderCubit>().getOrderVouchers(),
                            iconPosition: IconPosition.end,
                            icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
                            text: context.text.viewAll,
                          ),
                        ),
                    ],
                    Row(
                      children: [
                        AppText(context.text.noUseVoucher, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                        Spacer(),
                        ValueListenableBuilder(
                          valueListenable: noUseVoucherCode,
                          builder: (context, value, child) {
                            return Radio(
                              value: true,
                              groupValue: noUseVoucherCode.value,
                              onChanged: (value) {
                                noUseVoucherCode.value = value ?? false;
                                selectedOtherVoucher.value = Voucher();
                                selectedShippingVoucher.value = Voucher();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    GradientButton(
                      onPressed: () {
                        context.read<OrderCubit>()
                          ..setOrderVoucher(selectedOtherVoucher.value, selectedShippingVoucher.value)
                          ..updateOrderInfo();
                        DNavigator.back();
                      },
                      text: context.text.apply,
                      style: AppStyle.text14.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
