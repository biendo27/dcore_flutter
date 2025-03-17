part of '../livestream.dart';

class LiveBreakBody extends StatelessWidget {
  const LiveBreakBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveRequestCubit, LiveRequestState>(
      builder: (context, state) {
        if (state.liveRequests.data.isEmpty) {
          return const NoData();
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.liveRequests.data.length,
                itemBuilder: (context, index) {
                  return LiveBreakListItem(breakSchedule: state.liveRequests.data[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
