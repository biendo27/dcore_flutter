part of '../../shop.dart';

class CancelOrderPage extends StatefulWidget {
  const CancelOrderPage({super.key});

  @override
  State<CancelOrderPage> createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<CancelOrderPage> {
  TextEditingController descriptionController = TextEditingController();
  String selectedReason = "Chọn lý do hủy";

  void _choseReason() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => ReasonCancelBody(
        onReasonSelected: (reason) {
          debugPrint('Reason selected in ReasonCancelBody: $reason');
          setState(() {
            selectedReason = reason; // Debug
          });
          //  selectedReason =reason;// Debug
          Navigator.pop(context, reason); // Trả về giá trị đã chọn
        },
      ),
    );

    if (result != null && result.isNotEmpty) {
      debugPrint('Reason received in _choseReason: $result'); // Debug
      setState(() {
        selectedReason = result; // Cập nhật giá trị
      });
    } else {
      debugPrint('No reason selected or modal dismissed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderActionCubit, OrderActionState>(
      builder: (context, state) {
        return SubLayout(
          title: context.text.cancelOrder,
          isLoading: state.isLoading,
          resizeToAvoidBottomInset: true,
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
                          itemCount: state.cancelInfo.orderProducts.length,
                          itemBuilder: (context, index) {
                            return CancelOrderProductItem(product: state.cancelInfo.orderProducts[index].productInfo);
                          },
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              context.text.reasonCancel,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Expanded(
                                child: AppText(
                              maxLines: 2,
                              selectedReason, // Debug
                              //  state.selectedReason.isNotEmpty ? state.selectedReason : context.text.cancelReason,
                              //  context.text.selectReason,
                              onTap: _choseReason,
                              style: AppStyle.text14.copyWith(color: AppCustomColor.grey50),
                            )),
                          ],
                        ),
                        20.verticalSpace,
                        AppText(
                          context.text.descriptionReason,
                          style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                        ),
                        6.verticalSpace,
                        DTextField(
                          hint: context.text.descriptionReason,
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
                              state.cancelInfo.totalRefundAmount.currencyVND,
                              style: AppStyle.text14.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        DTitleAndText(
                          title: context.text.refundProduct,
                          text: state.cancelInfo.productRefundAmount.currencyVND,
                          titleStyle: AppStyle.text14,
                        ),
                        10.verticalSpace,
                        DTitleAndText(
                          title: context.text.refundShippingFee,
                          text: state.cancelInfo.shippingRefundAmount.currencyVND,
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
                  onPressed: () => context.read<OrderActionCubit>().sendOrderCancel(descriptionController.text),
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
