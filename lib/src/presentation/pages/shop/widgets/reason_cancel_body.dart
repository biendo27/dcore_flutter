part of '../shop.dart';

class ReasonCancelBody extends StatelessWidget {
  final ValueChanged<String> onReasonSelected;

  const ReasonCancelBody({super.key, required this.onReasonSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderActionCubit, OrderActionState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75 - MediaQuery.of(context).viewInsets.bottom,
          child: Column(
            children: [
              // Header
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
                      context.text.cancelReason,
                      expandFlex: 1,
                      style: AppStyle.text16.copyWith(color: AppColorLight.onSurface, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
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
              // List of reasons
              Expanded(
                child: ListView.builder(
                  itemCount: state.cancelCategories.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final reason = state.cancelCategories[index].name;
                    return ListTile(
                      title: AppText(reason, style: AppStyle.text12),
                      trailing: Radio<OrderCancelCategory>(
                        value: state.cancelCategories[index],
                        groupValue: state.currentCancelCategory,
                        onChanged: (value) {
                          debugPrint('Radio selected: ${value?.name}');
                          context.read<OrderActionCubit>().setCurrentCancelCategory(value!);
                          final reason = state.cancelCategories[index].name;
                          debugPrint('Tapped reason: $reason'); // Debug để xác nhận lý do đã chọn
                          onReasonSelected(reason); // Gọi callback
                          // Đóng modal và trả về giá trị
                        },
                      ),
                      onTap: () {
                        debugPrint('Tapped on reason: $reason');
                        onReasonSelected(reason); // Trả về lý do
                        Navigator.pop(context, reason);
                      },
                    );
                  },
                ),
              ),
              GradientButton(
                onPressed: () => DNavigator.back(),
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                text: context.text.chose,
              )
            ],
          ),
        );
      },
    );
  }
}
