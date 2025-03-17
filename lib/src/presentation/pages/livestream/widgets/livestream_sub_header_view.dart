part of '../livestream.dart';

class LivestreamSubHeaderView extends StatelessWidget {
  final LiveRole liveRole;

  const LivestreamSubHeaderView({
    super.key,
    this.liveRole = LiveRole.host,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        VoucherWidget(),
        Spacer(),
        BlocBuilder<LiveCubit, LiveState>(
          builder: (context, state) {
            if (!state.currentLive.isGiveGift) return const SizedBox.shrink();
            return LivestreamTargetView(liveRole: liveRole);
          },
        ),
      ],
    );
  }
}
