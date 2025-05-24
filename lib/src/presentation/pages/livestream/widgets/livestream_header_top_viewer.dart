part of '../livestream.dart';

class LivestreamHeaderTopViewer extends StatelessWidget {
  const LivestreamHeaderTopViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveViewerCubit, LiveViewerState>(
      builder: (context, state) {
        return Row(
          children: [
            if (state.viewers.isNotEmpty)
              LivestreamViewerAvatar(
                viewer: state.viewers[0],
                isHeader: true,
                rank: 0,
              ),
            if (state.viewers.length > 1)
              LivestreamViewerAvatar(
                viewer: state.viewers[1],
                isHeader: true,
                rank: 1,
              )
          ],
        );
      },
    );
  }
}
