part of '../livestream.dart';

class LivestreamCommentView extends StatelessWidget {
  final LiveRole liveRole;
  const LivestreamCommentView({super.key, required this.liveRole});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<LiveCommentCubit, LiveCommentState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is! ScrollEndNotification) return false;
                      if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
                      if (state.isLoading) return false;
                      context.read<LiveCommentCubit>().loadOldComment();
                      return true;
                    },
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                          stops: [0.4, 0.6, 0.85, 1.0], // Further shortened shadow distances
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: ListView.builder(
                        itemCount: state.liveComments.data.length, // Limit the number of comments to 3
                        reverse: true,
                        itemBuilder: (context, index) {
                          return LivestreamCommentItem(
                            liveRole: liveRole,
                            comment: state.liveComments.data[index],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
