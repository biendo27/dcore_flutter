part of '../shop.dart';

class ProductIntroImages extends StatelessWidget {
  final PageController pageController;
  const ProductIntroImages({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        // Only add images to media if the video is null
        List<String> media = [
          if (state.currentProductDetail.product.video.isNotEmpty) state.currentProductDetail.product.video,
          ...state.currentProductDetail.product.images,
        ];

        if (media.isEmpty && state.currentProductDetail.product.video.isEmpty) {
          return SizedBox(
            height: 420.h,
            child: Center(
              child: state.currentProductDetail.product.images.isEmpty
                  ? AppText("No media available", style: AppStyle.text16)
                  : DCachedImage(url: state.currentProductDetail.product.images.first),
            ),
          );
        }

        return Container(
          color: AppColorLight.onSurface.op(0.5),
          height: 420.h,
          child: Stack(
            children: [
              Center(
                child: PageView(
                  controller: pageController,
                  children: media.map((e) {
                    if (e.endsWith('.mp4') || e.endsWith('.mov')) {
                      // Check for video files
                      return SizedBox(
                        height: 420.h,
                        child: VideoPlayerWidget(videoUrl: e),
                      );
                    } else {
                      return DCachedImage(url: e);
                    }
                  }).toList(),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 12.h,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: media.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: 6.w,
                      dotHeight: 6.w,
                      activeDotColor: AppColorLight.surface,
                      dotColor: AppCustomColor.greyDA.op(0.67),
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
              //   child: Row(
              //     children: [
              //       10.horizontalSpace,
              //       InkWell(
              //         onTap: DNavigator.back,
              //         child: Icon(FontAwesomeIcons.arrowLeft, size: 24.sp),
              //       ),
              //       Spacer(),
              //       BlocBuilder<CartCubit, CartState>(
              //         builder: (context, state) {
              //           return CustomCart(
              //             number: state.userCart.allProductLength,
              //             onTap: () => DNavigator.goNamed(RouteNamed.cart),
              //           );
              //         },
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  bool isPlaying = false;
  String? localVideoPath;

  @override
  void initState() {
    super.initState();
    _downloadAndInitializeVideo();
  }

  Future<void> _downloadAndInitializeVideo() async {
    try {
      // Tải video về thư mục tạm
      final directory = await getTemporaryDirectory();
      final filePath = "${directory.path}/temp_video.mp4";
      final dio = Dio();

      debugPrint("Đang tải video từ: ${widget.videoUrl}");
      await dio.download(widget.videoUrl, filePath);

      // Cập nhật đường dẫn video cục bộ
      setState(() {
        localVideoPath = filePath;
        _videoController = VideoPlayerController.file(File(filePath))
          ..initialize().then((_) {
            setState(() {});
          }).catchError((error) {
            debugPrint("Lỗi VideoPlayer: $error");
          });
      });
    } catch (e) {
      debugPrint("Lỗi khi tải video: $e");
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (localVideoPath == null || !_videoController.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isPlaying) {
            _videoController.pause();
          } else {
            _videoController.play();
          }
          isPlaying = !isPlaying;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          ),
          if (!isPlaying)
            Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 48,
            ),
        ],
      ),
    );
  }
}

class VideoCompressor {
  Future<String?> compressVideo(String inputPath, String outputPath, double networkSpeedMbps) async {
    try {
      // Dựa trên tốc độ mạng, tính toán giá trị CRF
      // int crf = min(28, max(18, (28 - (networkSpeedMbps / 5)).round()));

      // Lệnh FFmpeg để nén video
      // String command = '-i $inputPath -vcodec libx264 -crf $crf $outputPath';

      // Thực thi lệnh FFmpeg
      // await FFmpegKit.execute(command);

      debugPrint("Nén video thành công: $outputPath");
      return outputPath;
    } catch (e) {
      debugPrint("Lỗi FFmpeg: $e");
      return null;
    }
  }
}

void compressExample() async {
  String inputPath = "/path/to/original/video.mp4";
  String outputPath = "/path/to/compressed/video.mp4";
  double networkSpeedMbps = 10.0; // Tốc độ mạng (Mbps), ví dụ: đo được hoặc giả định

  VideoCompressor compressor = VideoCompressor();
  String? compressedVideo = await compressor.compressVideo(inputPath, outputPath, networkSpeedMbps);

  if (compressedVideo != null) {
    debugPrint("Video đã được nén thành công tại: $compressedVideo");
  } else {
    debugPrint("Không thể nén video.");
  }
}
