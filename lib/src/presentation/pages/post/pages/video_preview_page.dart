part of '../post.dart';

class VideoPreviewPage extends StatefulWidget {
  const VideoPreviewPage({super.key});

  @override
  State<VideoPreviewPage> createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  late Future<void> _initializeVideoPlayerFuture;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayerFuture = _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    final state = context.read<CameraCubit>().state;
    if (!state.hasRecordedVideo || state.recordedVideoPath.isEmpty) return;
    context.read<CreatePostCubit>()
      ..init(state.recordedVideoPath)
      ..setOnVideoReady(_initVideoPlayer)
      ..mixAudioToVideo();
  }

  void _initVideoPlayer(String videoPath) async {
    if (_videoPlayerController != null) {
      _videoPlayerController?.pause();
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
    }
    _videoPlayerController = VideoPlayerController.file(File(videoPath));
    await _videoPlayerController?.initialize();
    await _videoPlayerController?.setLooping(true);
    await _videoPlayerController?.play();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraState>(
      builder: (context, state) {
        if (!state.hasRecordedVideo || state.recordedVideoPath.isEmpty) {
          return Center(child: AppText(context.text.noVideoRecorded));
        }

        return Scaffold(
          backgroundColor: AppColorLight.shadow,
          body: Stack(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_videoPlayerController == null) return const AppLoading();

                    return SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoPlayerController?.value.size.width,
                          height: _videoPlayerController?.value.size.height,
                          child: VideoPlayer(_videoPlayerController!),
                        ),
                      ),
                    );
                  }
                  // Handle initialization errors
                  if (snapshot.hasError) {
                    return Center(child: AppText('${context.text.errorLoadingVideo}: ${snapshot.error}'));
                  }
                  // Only show video if controller is initialized
                  if (!(_videoPlayerController?.value.isInitialized ?? true)) {
                    return const AppLoading();
                  }
                  return const AppLoading();
                },
              ),
              // Controls overlay
              Column(
                children: [
                  20.verticalSpace,
                  _buildSelectSoundButton(),
                  const Spacer(),
                  _buildPostVideoOptions(context, state),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectSoundButton() {
    return GestureDetector(
      onTap: selectSound,
      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColorLight.surface.op(0.15),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.music_note,
              color: AppColorLight.surface,
              size: 18.sp,
            ),
            6.horizontalSpace,
            BlocBuilder<CreatePostCubit, CreatePostState>(
              builder: (context, state) {
                return AppText(
                  state.selectedSoundName,
                  style: AppStyle.text14.copyWith(color: AppColorLight.surface),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostVideoOptions(BuildContext context, CameraState state) {
    return Container(
      color: Colors.black.op(0.7),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildOptionButton(
            icon: Icons.close,
            label: context.text.goBack,
            onTap: () => context.read<CameraCubit>().discardRecordedVideo(),
          ),
          _buildOptionButton(
            icon: Icons.check,
            label: context.text.upload,
            onTap: () => _postVideo(context),
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isHighlighted ? AppColorLight.primary : AppColorLight.surface,
            ),
            child: Icon(
              icon,
              color: isHighlighted ? AppColorLight.surface : AppColorLight.shadow,
              size: 30.sp,
            ),
          ),
          8.verticalSpace,
          AppText(
            label,
            style: AppStyle.text12.copyWith(
              color: AppColorLight.surface,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _postVideo(BuildContext context) {
    final state = context.read<CameraCubit>().state;
    final createPostState = context.read<CreatePostCubit>().state;
    if (state.recordedVideoPath.isNotEmpty && _videoPlayerController != null && !createPostState.isLoading) {
      DNavigator.pushReplacementNamed(RouteNamed.createPost);
      context.read<CreatePostCubit>().generateThumbnail();

      return;
    }

    DMessage.showMessage(message: context.text.processingVideo, type: MessageType.error);
  }

  void selectSound() {
    showDModalBottomSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      bodyWidget: SelectSoundBody(),
    );
  }
}
