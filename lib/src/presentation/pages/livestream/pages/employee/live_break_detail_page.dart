part of '../../livestream.dart';

class LiveBreakDetailPage extends StatelessWidget {
  const LiveBreakDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.details,
      body: BlocBuilder<LiveRequestCubit, LiveRequestState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LiveBreakDetailInfo(breakSchedule: state.currentLiveRequest),
                16.verticalSpace,
                AppText(context.text.duration, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500)),
                5.verticalSpace,
                Row(
                  children: [
                    LiveBreakDurationInfo(
                      title: context.text.from,
                      value: state.currentLiveRequest.startAt?.dateTimeString ?? '',
                    ),
                    10.horizontalSpace,
                    AppText(':', style: AppStyle.text20),
                    10.horizontalSpace,
                    LiveBreakDurationInfo(
                      title: context.text.to,
                      value: state.currentLiveRequest.endAt?.dateTimeString ?? '',
                    ),
                  ],
                ),
                16.verticalSpace,
                AppText(context.text.livePlatform, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500)),
                AppText(state.currentLiveRequest.livePlatform.name),
                16.verticalSpace,
                AppText(context.text.region, style: AppStyle.text16.copyWith(fontWeight: FontWeight.w500)),
                AppText(state.currentLiveRequest.area.name),
                Spacer(),
                if (state.currentLiveRequest.status == BreakScheduleStatus.pending ) ...[
                  DButton(
                    text: context.text.clear,
                    backgroundColor: AppCustomColor.redD0,
                    onPressed: () {
                      context.read<LiveRequestCubit>().deleteLiveRequest(state.currentLiveRequest.id);
                      DNavigator.back();
                    },
                  ),
                  20.verticalSpace,
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
