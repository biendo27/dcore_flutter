part of '../shop.dart';

class EvaluateBody extends StatefulWidget {
  final List<int> orderProductIds;

  const EvaluateBody({
    super.key,
    this.orderProductIds = const [],
  });

  @override
  State<EvaluateBody> createState() => _EvaluateBodyState();
}

class _EvaluateBodyState extends State<EvaluateBody> {
  ValueNotifier<int> selectedStarNotifier = ValueNotifier<int>(0);
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderActionCubit, OrderActionState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: MediaQuery.viewInsetsOf(context),
          child: SizedBox(
            height: 0.56.sh,
            child: LoadingWrap(
              isLoading: state.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          context.text.evaluate,
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
                  20.verticalSpace,
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(context.text.customerReview, style: AppStyle.text18.copyWith(fontWeight: FontWeight.w700)),
                          AppText(
                            "(${context.text.customerReviewHint})",
                            style: AppStyle.text12.copyWith(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              5,
                              (index) => IconButton(
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  selectedStarNotifier.value = index + 1;
                                },
                                icon: ValueListenableBuilder(
                                    valueListenable: selectedStarNotifier,
                                    builder: (context, value, child) {
                                      return Icon(
                                        Icons.star,
                                        color: index < value ? AppCustomColor.yellowFF : AppCustomColor.greyE5,
                                        size: 30.sp,
                                      );
                                    }),
                              ),
                            ),
                          ),
                          15.verticalSpace,
                          DTextField(
                            controller: reviewController,
                            hint: context.text.writeReview,
                            fillColor: AppColorLight.surface,
                            type: DTextInputType.multiline,
                            maxLines: 3,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: AppCustomColor.greyE5)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: AppCustomColor.greyE5)),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: AppCustomColor.greyE5)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: AppCustomColor.greyE5)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: AppCustomColor.greyE5)),
                          ),
                          10.verticalSpace,
                          OrderImageSection(images: state.actionImages),
                          20.verticalSpace,
                          GradientButton(
                            text: context.text.apply,
                            onPressed: () {
                              if (state.isLoading) return;
                              context.read<OrderActionCubit>().setReviewOrderData(
                                    orderId: widget.orderProductIds,
                                    rating: selectedStarNotifier.value,
                                    note: reviewController.text,
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
