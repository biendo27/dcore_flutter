part of '../shop.dart';

class EditNoteBody extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final OrderOverviewStoreInfo orderOverviewStoreInfo;
  const EditNoteBody({
    super.key,
    required this.title,
    required this.controller,
    required this.orderOverviewStoreInfo,
  });

  @override
  State<EditNoteBody> createState() => _EditNoteBodyState();
}

class _EditNoteBodyState extends State<EditNoteBody> {
  final int maxChars = 200;
  ValueNotifier<int> charCount = ValueNotifier(0);
  Timer debounce = Timer(const Duration(milliseconds: 0), () {});

  @override
  void initState() {
    super.initState();
    charCount.value = widget.controller.text.length;
    widget.controller.addListener(() {
      if (widget.controller.text.length > maxChars) {
        widget.controller.text = widget.controller.text.substring(0, maxChars);
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: maxChars),
        );
      }
      charCount.value = widget.controller.text.length;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        DTextField(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          controller: widget.controller,
          border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColorLight.surface)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColorLight.surface)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColorLight.surface)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColorLight.surface)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColorLight.surface)),
          type: DTextInputType.multiline,
          maxLines: 6,
          fillColor: AppColorLight.surface,
          hint: "${context.text.writeMessage}...",
          hintStyle: AppStyle.text14.copyWith(color: AppCustomColor.greyAC),
          onChanged: (value) {
            debounce.cancel();
            debounce = Timer(const Duration(milliseconds: 500), () {
              context.read<OrderCubit>().setStoreNote(widget.orderOverviewStoreInfo.infor.id, value);
            });
          },
        ),
        // Đếm số ký tự / 200
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ValueListenableBuilder(
              valueListenable: charCount,
              builder: (context, value, child) {
                return AppText(
                  '$value/$maxChars',
                  style: AppStyle.text14.copyWith(color: AppCustomColor.greyAC),
                );
              }),
        ),
        8.verticalSpace,
        GradientButton(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          onPressed: () {
            DNavigator.back();
            context.read<OrderCubit>().updateOrderInfo();
          },
          text: context.text.apply,
        ),
        20.verticalSpace,
      ],
    );
  }
}
