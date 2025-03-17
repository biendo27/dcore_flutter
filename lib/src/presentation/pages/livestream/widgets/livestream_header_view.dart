part of '../livestream.dart';

class LivestreamHeaderView extends StatelessWidget {
  final LiveRole liveRole;

  const LivestreamHeaderView({
    super.key,
    this.liveRole = LiveRole.host,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LivestreamHostInfo(liveRole: liveRole),
        Spacer(),
        LivestreamHeaderTopViewer(),
        LivestreamHeaderTralling(liveRole: liveRole),
      ],
    );
  }
}
