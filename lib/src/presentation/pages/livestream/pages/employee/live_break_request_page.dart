part of '../../livestream.dart';

class LiveBreakRequestPage extends StatefulWidget {
  const LiveBreakRequestPage({super.key});

  @override
  State<LiveBreakRequestPage> createState() => _LiveBreakRequestPageState();
}

class _LiveBreakRequestPageState extends State<LiveBreakRequestPage> {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController fromDayController = TextEditingController();
  TextEditingController toDayController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.scheduleLive,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      DNavigator.goNamed(RouteNamed.liveBreakList);
                      // context.read<LiveCubit>().getBreakScheduleList(isInit: true);
                      context.read<LiveRequestCubit>().getLiveRequestList(isInit: true);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.sort),
                        18.horizontalSpace,
                        AppText(context.text.liveScheduleList, style: AppStyle.text14),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15.sp,
                        ),
                      ],
                    ),
                  ),
                  26.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(context.text.fromDay),
                            5.verticalSpace,
                            DTextField(
                              controller: fromDayController,
                              hint: context.text.fromDay,
                              type: DTextInputType.date,
                            ),
                          ],
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(context.text.startTime),
                            5.verticalSpace,
                            DTextField(
                              controller: startTimeController,
                              hint: context.text.startTime,
                              type: DTextInputType.time,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(context.text.toDay),
                            5.verticalSpace,
                            DTextField(
                              controller: toDayController,
                              hint: context.text.toDay,
                              type: DTextInputType.date,
                            ),
                          ],
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(context.text.endTime),
                            5.verticalSpace,
                            DTextField(
                              controller: endTimeController,
                              hint: context.text.endTime,
                              type: DTextInputType.time,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppText(context.text.livePlatform),
                  BlocBuilder<LiveRequestCubit, LiveRequestState>(
                    builder: (context, state) {
                      return DDropDownButton(
                        hint: context.text.livePlatform,
                        items: state.livePlatforms
                            .map((e) => DropdownItem(
                                  value: e,
                                  label: e.name,
                                ))
                            .toList(),
                        hintStyle: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
                        selectedValue: state.selectedLivePlatform,
                        onChanged: (value) {
                          context.read<LiveRequestCubit>().setLivePlatform(value);
                        },
                      );
                    },
                  ),
                  AppText(context.text.region),
                  BlocBuilder<LiveRequestCubit, LiveRequestState>(
                    builder: (context, state) {
                      return DDropDownButton(
                        hint: context.text.region,
                        items: state.liveAreas
                            .map((e) => DropdownItem(
                                  value: e,
                                  label: e.name,
                                ))
                            .toList(),
                        hintStyle: AppStyle.text14.copyWith(color: AppColorLight.onSurface),
                        selectedValue: state.selectedLiveArea,
                        onChanged: (value) {
                          context.read<LiveRequestCubit>().setLiveArea(value);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            GradientButton(
              onPressed: () => context.read<LiveRequestCubit>().createLiveRequest(
                    startTime: startTimeController.text,
                    endTime: endTimeController.text,
                    fromDay: fromDayController.text,
                    toDay: toDayController.text,
                  ),
              text: context.text.confirm,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
