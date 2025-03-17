part of '../../shop.dart';

class RefundOrderPage extends StatefulWidget {
  const RefundOrderPage({super.key});

  @override
  State<RefundOrderPage> createState() => _RefundOrderPageState();
}

class _RefundOrderPageState extends State<RefundOrderPage> {
  ValueNotifier<List<Product>> productsNotifier = ValueNotifier([]);
  TextEditingController descriptionController = TextEditingController();

  void _choseReason() {
    showDModalBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: ReasonRefundBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderActionCubit, OrderActionState>(
      builder: (context, state) {
        return SubLayout(
          title: context.text.returnOrder,
          isLoading: state.isLoading,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.returnInfo.orderProducts.length,
                          itemBuilder: (context, index) {
                            return RefundOrderProductItem(orderProduct: state.returnInfo.orderProducts[index]);
                          },
                        ),
                        20.verticalSpace,
                        BlocBuilder<OrderActionCubit, OrderActionState>(
                          builder: (context, state) {
                            return OrderImageSection(
                              images: state.actionImages,
                            );
                          },
                        ),
                        12.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              context.text.reasonReturn,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                            ),
                            AppText(
                              context.text.selectReason,
                              onTap: _choseReason,
                              style: AppStyle.text14.copyWith(color: AppCustomColor.grey50),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        AppText(
                          context.text.descriptionReason,
                          style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                        ),
                        6.verticalSpace,
                        DTextField(
                          hint: context.text.reasonReturnDetail,
                          hintStyle: AppStyle.text14.copyWith(color: AppCustomColor.black2D.op(0.6)),
                          maxLines: 3,
                          controller: descriptionController,
                          type: DTextInputType.multiline,
                          fillColor: AppColorLight.surface,
                        ),
                        12.verticalSpace,
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 14.sp),
                            6.horizontalSpace,
                            AppText(
                              context.text.refundDetail,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            AppText(
                              state.returnInfo.totalRefundAmount.currencyVND,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        DTitleAndText(
                          title: context.text.refundProduct,
                          text: state.returnInfo.productRefundAmount.currencyVND,
                          titleStyle: AppStyle.text14,
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                GradientButton(
                  text: context.text.apply,
                  onPressed: () => context.read<OrderActionCubit>().sendOrderReturn(descriptionController.text),
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500, color: AppColorLight.surface),
                ),
                10.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
