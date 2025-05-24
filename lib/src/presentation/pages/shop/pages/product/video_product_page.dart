part of '../../shop.dart';

class VideoProductPage extends StatefulWidget {
  const VideoProductPage({super.key});

  @override
  State<VideoProductPage> createState() => _VideoProductPageState();
}

class _VideoProductPageState extends State<VideoProductPage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() async {
    Post post = AppConfig.context!.read<PostCubit>().state.currentPost;
    _videoController = VideoPlayerController.networkUrl(Uri.parse(post.video))..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: VideoViewItem(
              post: Post(),
              videoPlayerController: _videoController,
              isPreview: true,
            ),
          ),
          PinProductVideoItem(),
        ],
      ),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
