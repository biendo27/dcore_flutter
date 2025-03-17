part of '../../livestream.dart';

class LiveBreakListPage extends StatelessWidget {
  const LiveBreakListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubLayout(
      title: context.text.liveLeaveList,
      isLoading: context.select((LiveCubit cubit) => cubit.state.isLoading),
      // onRefresh: () => context.read<LiveCubit>().getBreakScheduleList(isInit: true),
      // onLoadMore: () => context.read<LiveCubit>().getBreakScheduleList(),
      onRefresh: () => context.read<LiveRequestCubit>().getLiveRequestList(isInit: true),
      onLoadMore: () => context.read<LiveRequestCubit>().getLiveRequestList(),
      body: const LiveBreakBody(),
    );
  }
}
