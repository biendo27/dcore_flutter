part of '../shop.dart';

class DiscountFromSellerBody extends StatefulWidget {
  final String title;
  final OrderOverviewStoreInfo storeInfo;
  const DiscountFromSellerBody({
    super.key,
    required this.title,
    required this.storeInfo,
  });

  @override
  State<DiscountFromSellerBody> createState() => _DiscountFromSellerBodyState();
}

class _DiscountFromSellerBodyState extends State<DiscountFromSellerBody> {
  ValueNotifier<Voucher> selectedVoucherNotifier = ValueNotifier(Voucher());

  @override
  void initState() {
    _initListener();
    super.initState();
  }

  void _initData(List<Voucher> vouchers) {
    int storeVoucherId = widget.storeInfo.storeVoucher.id;
    if (storeVoucherId == 0) return;
    Voucher voucher = vouchers.firstWhere((e) => e.id == storeVoucherId);
    selectedVoucherNotifier.value = voucher;
  }

  void _initListener() {
    // selectedVoucherNotifier.addListener(() {
    //   context.read<OrderCubit>().setStoreVoucher(widget.storeInfo.infor.id, selectedVoucherNotifier.value);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.85.sh - MediaQuery.viewInsetsOf(context).bottom,
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
                  widget.title,
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
          BlocConsumer<OrderCubit, OrderState>(
            listener: (context, state) {
              if (state.storeVouchers.data.isNotEmpty && selectedVoucherNotifier.value.id == 0) {
                _initData(state.storeVouchers.data);
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const AppLoading();
              }

              if (state.storeVouchers.data.isEmpty) {
                return NoData();
              }

              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: AppText(
                              context.text.voucher,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          16.verticalSpace,
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              itemCount: state.storeVouchers.data.length,
                              itemBuilder: (context, index) {
                                return DiscountItem(
                                  voucher: state.storeVouchers.data[index],
                                  selectedVoucherNotifier: selectedVoucherNotifier,
                                  onChanged: (voucher) => context.read<OrderCubit>().setStoreVoucher(widget.storeInfo.infor.id, voucher ?? Voucher()),
                                );
                              },
                            ),
                          ),
                          10.verticalSpace,
                          if (!state.storeVouchers.isLastPage)
                            Center(
                              child: DIconText(
                                onTap: () => context.read<OrderCubit>().getStoreVouchers(storeInfo: widget.storeInfo),
                                iconPosition: IconPosition.end,
                                icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
                                text: context.text.viewAll,
                              ),
                            ),
                          Row(
                            children: [
                              16.horizontalSpace,
                              AppText(context.text.noUseVoucher, style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500)),
                              Spacer(),
                              ValueListenableBuilder(
                                valueListenable: selectedVoucherNotifier,
                                builder: (context, selectedValue, child) {
                                  return Radio(
                                    value: Voucher(),
                                    groupValue: selectedValue,
                                    onChanged: (voucher) {
                                      selectedVoucherNotifier.value = voucher ?? Voucher();
                                      context.read<OrderCubit>().setStoreVoucher(widget.storeInfo.infor.id, Voucher());
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GradientButton(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      onPressed: () {
                        context.read<OrderCubit>().updateOrderInfo();
                        DNavigator.back();
                      },
                      text: context.text.apply,
                      style: AppStyle.text14.copyWith(color: AppColorLight.surface, fontWeight: FontWeight.w500),
                    ),
                    20.verticalSpace,
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
