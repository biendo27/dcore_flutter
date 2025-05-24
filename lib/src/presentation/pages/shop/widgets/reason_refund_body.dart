part of '../shop.dart';

class ReasonRefundBody extends StatelessWidget {
  const ReasonRefundBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75 - MediaQuery.viewInsetsOf(context).bottom,
      child: Column(
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
                  context.text.reasonReturn,
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
          BlocBuilder<OrderActionCubit, OrderActionState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.returnCategories.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => ListTile(
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.only(left: 16.w),
                    title: AppText(state.returnCategories[index].name, style: AppStyle.text12),
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Radio<OrderReturnCategory>(
                        value: state.returnCategories[index],
                        groupValue: state.currentReturnCategory,
                        onChanged: (OrderReturnCategory? value) => context.read<OrderActionCubit>().setCurrentReturnCategory(value ?? state.returnCategories[0]),
                      ),
                    ),
                    onTap: () => context.read<OrderActionCubit>().setCurrentReturnCategory(state.returnCategories[index]),
                  ),
                ),
              );
            },
          ),
          GradientButton(
            onPressed: () => DNavigator.back(),
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            text: context.text.chose,
          )
        ],
      ),
    );
  }
}
