part of '../livestream.dart';

class UserLivestreamAgoraView extends StatefulWidget {
  const UserLivestreamAgoraView({super.key});

  @override
  State<UserLivestreamAgoraView> createState() => _UserLivestreamAgoraViewState();
}

class _UserLivestreamAgoraViewState extends State<UserLivestreamAgoraView> {
  List<Widget> hearts = [];

  void _addHeart() {
    final double left = Random().nextDouble() * MediaQuery.of(context).size.width;

    setState(() {
      hearts.add(_buildHeart(left));
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (hearts.isNotEmpty) {
        setState(() {
          hearts.removeAt(0);
        });
      }
    });
  }

  Widget _buildHeart(double left) {
    return Positioned(
      bottom: 50,
      left: left,
      child: TweenAnimationBuilder<Offset>(
        tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -200)),
        duration: const Duration(seconds: 2),
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: Opacity(
              opacity: 1 - (offset.dy / -200),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveSettingCubit, LiveSettingState>(
      builder: (context, state) {
        if (state.liveStatus == LiveSettingStatus.preLive || state.audienceId == 0) {
          return Container(
            color: AppColorLight.shadow,
            child: AppLoading(),
          );
        }

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onDoubleTap: () {
            context.read<LiveCubit>().liveLike();
            _addHeart();
          },
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: AppColorLight.shadow,
                alignment: Alignment.center,
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    connection: RtcConnection(channelId: context.read<LiveCubit>().state.currentLive.roomId),
                    rtcEngine: context.read<LiveSettingCubit>().liveService.agoraEngine,
                    canvas: VideoCanvas(uid: state.audienceId),
                  ),
                  onAgoraVideoViewCreated: (viewId) {},
                ),
              ),
              PageView.builder(
                controller: PageController(initialPage: 1),
                itemCount: 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SizedBox.expand();
                  }

                  return LivestreamExtendUI(liveRole: LiveRole.audience);
                },
              ),
              LiveHeartSession(),
              LiveGiftSession(),
              LiveGiftRecipientSession(),
              ...hearts,
            ],
          ),
        );
      },
    );
  }
}
