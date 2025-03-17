part of '../livestream.dart';

class LiveCensorFormBody extends StatelessWidget {
  final int order;
  final CensorResult censorResult;
  final TextEditingController pointController;
  final TextEditingController reviewController;
  final bool readOnly;
  const LiveCensorFormBody({
    super.key,
    this.order = 0,
    required this.censorResult,
    required this.pointController,
    required this.reviewController,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (censorResult.value != 0) pointController.text = censorResult.value.toString();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      margin: EdgeInsets.only(top: 10.h),
      decoration: ShapeDecoration(
        color: AppThemeMaterial.lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: BorderSide(color: AppCustomColor.blueCE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('${order + 1}. ${censorResult.censor.name}', style: AppStyle.text16),
          Divider(color: AppCustomColor.blueCE, height: 28.h),
          AppText(context.text.description, style: AppStyle.textBold14),
          HtmlWidget(
            censorResult.censor.description,
            textStyle: AppStyle.text14,
          ),
          10.verticalSpace,
          Row(
            children: [
              AppText(context.text.ratingScore, style: AppStyle.textBold14),
              Spacer(),
              DHighlightText(
                text: '${context.text.maximumScore}: ${censorResult.censor.pointMax}',
                highlights: ['${censorResult.censor.pointMax}'],
                style: AppStyle.textBold14,
                highlightStyles: [AppStyle.textBold14.copyWith(color: AppCustomColor.redD0)],
              ),
            ],
          ),
          10.verticalSpace,
          DTextField(
            controller: pointController,
            hint: context.text.ratingPoints,
            textAlign: TextAlign.end,
            maxLength: 1,
            type: DTextInputType.number,
            counterText: '',
            fillColor: AppColorLight.onPrimary,
            readOnly: readOnly,
          ),
          DTextField(
            controller: reviewController,
            hint: context.text.review,
            fillColor: AppColorLight.onPrimary,
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}
