part of '../post.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with SingleTickerProviderStateMixin, WidgetsBindingObserver, RouteAware {
  CameraController cameraController = CameraController(CameraService.cameras.first, ResolutionPreset.high);
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CameraCubit>().reset();
      context.read<SoundCubit>().initSoundList();
      _initializeCamera();
      _initializeVideoPlayer();
    });
  }

  Future<void> _initializeCamera() async {
    final controller = await CameraService.initializeCamera();
    if (controller != null) {
      cameraController = controller;
      if (!mounted) return;
      context.read<CameraCubit>().setInitialized(true);
      return;
    }

    if (!mounted) return;
    context.read<CameraCubit>().setErrorMessage('Failed to initialize camera');
  }

  void _initializeVideoPlayer() async {
    String audioPath = context.read<CreatePostCubit>().state.selectedSound.audio;
    if (audioPath.isEmpty || !mounted) return;
    await audioPlayer.setUrl(audioPath);
    await audioPlayer.setLoopMode(LoopMode.all);
  }

  void _changePlayVideoState() {
    if (audioPlayer.audioSource == null) return;
    if (audioPlayer.playing) {
      audioPlayer.pause();
      return;
    }
    audioPlayer.play();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
      return;
    }
    if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  void didPushNext() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
      audioPlayer.seek(Duration.zero);
    }
  }

  @override
  void didPopNext() {
    // audioPlayer.play();
  }

  @override
  void dispose() {
    cameraController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocBuilder<CameraCubit, CameraState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColorLight.shadow,
            body: !state.isInitialized
                ? const AppLoading()
                : Stack(
                    children: [
                      CameraPreview(cameraController),
                      _buildOverlay(state),
                      if (state.isRecording) _buildRecordingProgressBar(state),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildOverlay(CameraState state) {
    return SafeArea(
      child: Column(
        children: [
          if (!state.isRecording) _buildTopBar(state),
          const Spacer(),
          if (!state.isRecording && state.mode == CameraMode.video) const RecordOption(),
          20.verticalSpace,
          _buildBottomBar(state),
        ],
      ),
    );
  }

  Widget _buildRecordingProgressBar(CameraState state) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: LinearProgressIndicator(
        value: state.recordingProgress,
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(AppColorLight.primary),
      ),
    );
  }

  Widget _buildTopBar(CameraState state) {
    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColorLight.surface),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: Icon(_getFlashIcon(state.flashMode), color: AppColorLight.surface),
            onPressed: () async {
              await CameraService.toggleFlash(cameraController);
              if (!mounted) return;
              context.read<CameraCubit>().toggleFlash();
            },
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios, color: AppColorLight.surface),
            onPressed: () async {
              cameraController = (await CameraService.switchCamera(cameraController))!;
              if (!mounted) return;
              context.read<CameraCubit>().switchCamera();
            },
          ),
        ],
      ),
    );
  }

  IconData _getFlashIcon(FlashMode flashMode) {
    return flashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on;
  }

  Widget _buildBottomBar(CameraState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (!state.isRecording) _buildGalleryButton(),
          _buildCaptureButton(state),
          if (!state.isRecording) _buildSwitchModeButton(state),
        ],
      ),
    );
  }

  Widget _buildGalleryButton() {
    return GestureDetector(
      onTap: _openGallery,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.black.op(0.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: const Icon(Icons.photo_library, color: AppColorLight.surface),
      ),
    );
  }

  Future<void> _openGallery() async {
    final CameraCubit cameraCubit = context.read<CameraCubit>();

    if (cameraCubit.state.mode != CameraMode.video) return;

    try {
      final pickedVideo = await MediaService.pickVideo();
      if (pickedVideo == null || !mounted) return;
      cameraCubit.setGalleryVideo(pickedVideo.path);
    } catch (e) {
      if (!mounted) return;
      DMessage.showMessage(message: '${context.text.errorAccessingGallery}: $e', type: MessageType.error);
    }
  }

  Widget _buildCaptureButton(CameraState state) {
    final isRecording = state.isRecording;
    final isVideoMode = state.mode == CameraMode.video;

    return GestureDetector(
      onTap: _onCaptureButtonPressed,
      child: Container(
        width: 70.w,
        height: 70.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColorLight.surface,
            width: 3.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorLight.surface,
            ),
            child: Center(
              child: Icon(
                _getCaptureIcon(isVideoMode, isRecording),
                color: isRecording ? AppColorLight.primary : AppColorLight.shadow,
                size: 30.r,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCaptureIcon(bool isVideoMode, bool isRecording) {
    if (isVideoMode) {
      return isRecording ? Icons.stop : Icons.videocam;
    } else {
      return Icons.camera_alt;
    }
  }

  Widget _buildSwitchModeButton(CameraState state) {
    return SizedBox(
      width: 40.w,
      height: 40.w,
    );
    // return GestureDetector(
    //   onTap: () => context.read<CameraCubit>().switchMode(),
    //   child: Container(
    //     width: 40,
    //     height: 40,
    //     decoration: BoxDecoration(
    //       color: Colors.black.op(0.5),
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     child: Icon(
    //       state.mode == CameraMode.photo ? Icons.videocam : Icons.camera_alt,
    //       color: AppColorLight.surface,
    //     ),
    //   ),
    // );
  }

  void _onCaptureButtonPressed() async {
    final cameraCubit = context.read<CameraCubit>();
    final state = cameraCubit.state;
    if (state.mode == CameraMode.photo) {
      final picture = await CameraService.takePicture(cameraController);
      if (picture == null) return;
      if (!mounted) return;
      LogDev.info('${context.text.pictureSavedTo}: ${picture.path}');
      return;
    }

    if (!state.isRecording) {
      await CameraService.startVideoRecording(cameraController);
      cameraCubit.startRecording(cameraController);
      _changePlayVideoState();
      return;
    }

    final videoPath = await CameraService.stopVideoRecording(cameraController);
    if (videoPath.isEmpty) return;
    cameraCubit.stopRecording(videoPath);
    _changePlayVideoState();
    LogDev.info('Video recorded successfully, path: $videoPath');
  }
}
