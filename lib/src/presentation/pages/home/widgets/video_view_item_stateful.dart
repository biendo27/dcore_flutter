part of '../home.dart';

class VideoViewItemStateful extends StatefulWidget {
  final Post post;
  final bool isPreview;

  const VideoViewItemStateful({
    super.key,
    required this.post,
    this.isPreview = false,
  });

  @override
  State<VideoViewItemStateful> createState() => _VideoViewItemStatefulState();
}

class _VideoViewItemStatefulState extends State<VideoViewItemStateful> {
  Post get post => widget.post;
  bool get isPreview => widget.isPreview;
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(post.video));
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      AppConfig.context!.read<VideoCubit>().toggleIsPlaying(false);
      // audioPlayer.pause();
      return;
    }
    videoPlayerController.play();
    AppConfig.context!.read<VideoCubit>().toggleIsPlaying(true);
    // audioPlayer.play();
  }

  Widget _buildVideoPlayer() {
    return InkWell(
      onTap: _togglePlayPause,
      child: Ink(
        color: AppColorLight.shadow,
        child: videoPlayerController.value.isInitialized ? _buildInitializedVideo() : _buildInitializingVideo(),
      ),
    );
  }

  Widget _buildInitializedVideo() {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: videoPlayerController.value.size.width,
                  height: videoPlayerController.value.size.height,
                  child: VideoPlayer(videoPlayerController),
                ),
              ),
            ),
            if (!state.isPlaying) Icon(Icons.play_arrow_rounded, color: AppColorLight.surface.op(0.7), size: 70.sp)
          ],
        );
      },
    );
  }

  Widget _buildInitializingVideo() {
    return FutureBuilder(
      future: videoPlayerController.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // audioPlayer.play();
          videoPlayerController.play();
          context.read<PostCubit>().markAsReadPost(post.id);
          return _buildInitializedVideo();
        }
        return const AppLoading();
      },
    );
  }

  Widget _buildVideoInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UserInfo(post: post),
            InteractionButtons(post: post, isPreview: isPreview),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildVideoPlayer(),
        _buildVideoInfo(),
      ],
    );
  }
}
