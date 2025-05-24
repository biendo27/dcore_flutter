part of '../utils.dart';

/// Stateful widget to fetch and then display video content.
class VideoView extends StatefulWidget {
  final String url;
  const VideoView({super.key, required this.url});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;

  bool isShowPlay = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Center(
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: isShowPlay ? Colors.white.op(0.5) : Colors.transparent,
                onPressed: () => setState(() {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                  Future.delayed(const Duration(seconds: 1), () {
                    isShowPlay = !isShowPlay;
                    setState(() {});
                  });
                }),
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: isShowPlay ? Colors.white : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
