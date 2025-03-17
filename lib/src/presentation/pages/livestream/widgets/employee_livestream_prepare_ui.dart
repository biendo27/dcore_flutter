part of '../livestream.dart';

class EmployeeLivestreamPrepareUI extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const EmployeeLivestreamPrepareUI({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Unfocused(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              DIconText(
                icon: Icon(Icons.arrow_back_rounded, color: AppColorLight.surface),
                spacing: 12,
                text: context.text.startLive,
                textStyle: AppStyle.text18.copyWith(color: AppColorLight.surface),
                onTap: () {
                  context
                    ..read<LiveSettingCubit>().leaveLive()
                    ..read<LiveSocketCubit>().leaveLive();

                  DNavigator.back();
                },
              ),
              20.verticalSpace,
              EmployeeLivestreamInfo(
                titleController: titleController,
                descriptionController: descriptionController,
              ),
              20.verticalSpace,
              Center(
                child: GradientButton(
                  size: Size(260.w, 35.h),
                  onPressed: () {
                    context.read<LiveCubit>()
                      ..startLive(
                        title: titleController.text,
                        description: descriptionController.text,
                        onSuccess: () => AppConfig.context?.read<LiveCubit>().markAsRead(),
                      )
                      ..getLiveBooth();

                    context.read<LiveSettingCubit>().setLiveStatus(LiveSettingStatus.live);
                  },
                  text: context.text.livestream,
                ),
              ),
              // 80.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
