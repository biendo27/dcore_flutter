part of '../message.dart';

class VideosView extends StatefulWidget {
  final ChatMessage? message;

  const VideosView({super.key, this.message});

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  String? videoPath = '';
  late video.VideoPlayerController videoPlayerController;
  late Timer timer;
  late Duration duration;
  bool isExceptionError = false;
  bool isUIVisible = false;

  @override
  void initState() {
    videoPath = widget.message?.video;
    videoInit();
    super.initState();
  }

  void videoInit() {
    duration = const Duration();
    videoPlayerController = video.VideoPlayerController.networkUrl(
      Uri.parse('${ConstRes.itemBaseUrl}$videoPath'),
    )..initialize().then((value) {
      videoPlayerController.play().then((value) {
        isUIVisible = true;
        setState(() {});
      });
      timer = Timer.periodic(videoPlayerController.value.position, (timer) {
        duration = videoPlayerController.value.position;
        setState(() {});
      });
    }).onError((e, e1) {
      isExceptionError = true;
      setState(() {});
    }).catchError((e) {
      isExceptionError = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            isExceptionError
                ? Center(
                    child: AppText(
                      context.text.videoError,
                      style: AppStyle.text14.copyWith(color: Colors.white),
              ),
            )
                : Center(
              child: AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: video.VideoPlayer(videoPlayerController),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                width: double.infinity,
                child: InkWell(
                  onTap: onPlayPauseTap,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: AnimatedOpacity(
                    opacity: isUIVisible == true ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Icon(
                      videoPlayerController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    '${_printDuration(duration)} / ${_printDuration(videoPlayerController.value.duration)}',
                    style: AppStyle.text14.copyWith(color: Colors.white),
                  ),
                  video.VideoProgressIndicator(
                    videoPlayerController,
                    allowScrubbing: true,
                    colors: video.VideoProgressColors(
                        backgroundColor: Colors.white,
                        playedColor: AppCustomColor.orangeF1),
                    padding: const EdgeInsets.only(bottom: 15, top: 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigits(duration.inHours) == '00') {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void onPlayPauseTap() {
    isUIVisible = !isUIVisible;
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    if (!isExceptionError) {
      timer.cancel();
    }
    super.dispose();
  }
}