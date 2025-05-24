part of '../livestream.dart';

class LiveScheduleBody extends StatelessWidget {
  const LiveScheduleBody({super.key});

  @override
  Widget build(BuildContext context) {
    final LiveState state = context.watch<LiveCubit>().state;
    if (state.myScheduleList.data.isEmpty) {
      return const NoData();
    }
    return Expanded(
      child: Container(
        color: AppCustomColor.greyF5,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: ListView.builder(
          itemCount: state.myScheduleList.data.length,
          itemBuilder: (context, index) {
            return LiveScheduleListDayItem(
              day: state.myScheduleList.data[index].date,
              items: state.myScheduleList.data[index].details
                  .map((e) => LiveScheduleListItem(
                        liveData: e,
                        latestLiveId: state.nearestLive.id,
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
