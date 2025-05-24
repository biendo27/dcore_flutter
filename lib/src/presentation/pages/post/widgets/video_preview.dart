part of '../post.dart';

class VideoPreview extends StatefulWidget {
  final String videoPath;
  final String thumbnailPath;
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const VideoPreview({
    super.key,
    required this.videoPath,
    required this.thumbnailPath,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath));
    _initializeVideoPlayerFuture = _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await _controller.initialize();
      await _controller.setLooping(true);
    } catch (e) {
      LogDev.error('Error initializing video: $e');
      rethrow;
    }
  }

  void _togglePlay() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColorLight.scrim,
              borderRadius: widget.borderRadius,
            ),
            child: const AppLoading(),
          );
        }

        if (snapshot.hasError) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColorLight.scrim,
              borderRadius: widget.borderRadius,
            ),
            child: const Center(
              child: Icon(Icons.error_outline, color: AppColorLight.error),
            ),
          );
        }

        return GestureDetector(
          onTap: _togglePlay,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: widget.borderRadius ?? BorderRadius.zero,
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: !_isPlaying
                      ? DCachedImage(
                          url: widget.thumbnailPath,
                          width: widget.width,
                          height: widget.height,
                          borderRadius: widget.borderRadius,
                        )
                      : SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: widget.width,
                              height: widget.height,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        ),
                ),
              ),
              if (!_isPlaying)
                Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: Colors.black.op(0.3),
                    borderRadius: widget.borderRadius,
                  ),
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 30.sp,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
