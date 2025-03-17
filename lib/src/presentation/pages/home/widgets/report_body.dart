part of '../home.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

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
                  context.text.report,
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
          BlocBuilder<ReportCubit, ReportState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.reports.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => ListTile(
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.only(left: 16.w),
                    title: AppText(state.reports[index].name, style: AppStyle.text12),
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Radio<Report>(
                        value: state.reports[index],
                        groupValue: state.currentReport,
                        onChanged: (Report? value) => context.read<ReportCubit>().setCurrentReport(value ?? state.reports[0]),
                      ),
                    ),
                    onTap: () => context.read<ReportCubit>().setCurrentReport(state.reports[index]),
                  ),
                ),
              );
            },
          ),
          GradientButton(
            onPressed: () {
              int currentPostId = context.read<PostCubit>().state.currentPostFromIndex.id;
              context.read<ReportCubit>().createReport(currentPostId);
              DNavigator.back();
            },
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            text: context.text.report,
          )
        ],
      ),
    );
  }
}
