part of '../home.dart';

class VideoViewItem extends StatelessWidget {
  final Post post;
  final VideoPlayerController videoPlayerController;
  final bool isPreview;

  const VideoViewItem({
    super.key,
    required this.post,
    required this.videoPlayerController,
    this.isPreview = false,
  });

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

  void _togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      AppConfig.context!.read<VideoCubit>().toggleIsPlaying(false);
      return;
    }
    videoPlayerController.play();
    AppConfig.context!.read<VideoCubit>().toggleIsPlaying(true);
  }

  Widget _buildVideoPlayer() {
    return InkWell(
      onTap: _togglePlayPause,
      child: Column(
        children: [
          Expanded(
            child: Ink(
              color: AppColorLight.shadow,
              child: videoPlayerController.value.isInitialized ? _buildInitializedVideo() : _buildInitializingVideo(),
            ),
          ),
          // Thanh tua video
          if (videoPlayerController.value.isInitialized) _buildVideoProgressIndicator(),
        ],
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
            if (!state.isPlaying) Icon(Icons.play_arrow_rounded, color: AppColorLight.surface.op(0.7), size: 70.sp),
          ],
        );
      },
    );
  }

  Widget _buildInitializingVideo() {
    return FutureBuilder(
      future: videoPlayerController.initialize(),
      builder: (context, snapshot) {
        PostCubit postCubit = context.read<PostCubit>();
        if (snapshot.connectionState == ConnectionState.done) {
          videoPlayerController.play();
          context.read<VideoCubit>().toggleIsPlaying(true);
          postCubit.markAsReadPost(post.id);
          if (postCubit.state.currentPostFromIndex.id != post.id) {
            videoPlayerController.pause();
            context.read<VideoCubit>().toggleIsPlaying(false);
          }
          return _buildInitializedVideo();
        }

        if (snapshot.hasError) {
          return Center(child: AppText('Error loading video: ${snapshot.error}'));
        }

        if (!videoPlayerController.value.isInitialized) {
          return const AppLoading();
        }

        return const AppLoading();
      },
    );
  }

  Widget _buildVideoProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          VideoProgressIndicator(
            videoPlayerController,
            allowScrubbing: true, // Cho phép kéo để tua
            colors: VideoProgressColors(
              playedColor: Colors.grey, // Màu đoạn video đã xem
              bufferedColor: Colors.white, // Màu đoạn video đã tải trước
              backgroundColor: Colors.black, // Màu nền
            ),
          ),
        ],
      ),
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
}
