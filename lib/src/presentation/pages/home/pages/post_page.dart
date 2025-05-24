part of '../home.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with RouteAware, WidgetsBindingObserver {
  late VideoPlayerController _videoController;
  // late AudioPlayer _audioPlayer;
  late RouteObserver<ModalRoute<void>> _routeObserver;

  @override
  void initState() {
    super.initState();
    _routeObserver = RouteObserver<ModalRoute<void>>();
    WidgetsBinding.instance.addObserver(this);
    _initializeController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPushNext() {
    // Route is obscured by another route
    _videoController.pause();
    // context.read<PostCubit>().toggleIsPlaying(false);
  }

  @override
  void didPopNext() {
    // Route is revealed after popping another route
    _videoController.play();
    // context.read<PostCubit>().toggleIsPlaying(true);
  }

  void _initializeController() async {
    Post post = AppConfig.context!.read<PostCubit>().state.currentPost;
    _videoController = VideoPlayerController.networkUrl(Uri.parse(post.video))..setLooping(true);
    // context.read<PostCubit>().toggleIsPlaying(true);
    // _audioPlayer = AudioPlayer()
    //   ..setUrl(post.sound.audio)
    //   ..setLoopMode(LoopMode.all);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _videoController.pause();
    }
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Container(
        // margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
        child: VideoViewItem(
          post: context.select((PostCubit cubit) => cubit.state.currentPost),
          videoPlayerController: _videoController,
          isPreview: true,
        ),
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
