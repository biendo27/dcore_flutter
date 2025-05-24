part of '../home.dart';

class VideoAudioPage extends StatefulWidget {
  const VideoAudioPage({super.key});

  @override
  State<VideoAudioPage> createState() => _VideoAudioPageState();
}

class _VideoAudioPageState extends State<VideoAudioPage> with WidgetsBindingObserver, RouteAware {
  late AudioPlayer _audioPlayer;
  late RouteObserver<ModalRoute<void>> _routeObserver;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _routeObserver = RouteObserver<ModalRoute<void>>();
    WidgetsBinding.instance.addObserver(this);
    _initAudio();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void _initAudio() async {
    final soundState = context.read<SoundCubit>().state;
    final audioUrl = soundState.currentSound.audio;
    if (audioUrl.isNotEmpty) {
      try {
        await _audioPlayer.setUrl(audioUrl);
        await _audioPlayer.setLoopMode(LoopMode.all); // Set looping mode
        _playAudio();
      } catch (e) {
        LogDev.error('Error setting audio: $e');
      }
    }
  }

  void _playAudio() {
    _audioPlayer.play();
    if (!mounted) return;
    _scaffoldKey.currentState?.context.read<SoundCubit>().setAudioPlaying(true);
  }

  void _stopAudio() {
    _audioPlayer.stop();
    if (!mounted) return;
    _scaffoldKey.currentState?.context.read<SoundCubit>().setAudioPlaying(false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _stopAudio();
    } else if (state == AppLifecycleState.resumed) {
      // _playAudio();
    }
  }

  @override
  void didPushNext() {
    // Called when a new route has been pushed, and the current route is no longer visible.
    _stopAudio();
  }

  @override
  void didPopNext() {
    // Called when the top route has been popped off, and the current route shows up.
    // _playAudio();
  }

  @override
  void dispose() {
    _stopAudio();
    _audioPlayer.dispose();
    _routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          _stopAudio();
        }
      },
      child: SubLayout(
        scaffoldKey: _scaffoldKey,
        title: context.text.videoAudio,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SoundCubit, SoundState>(
                builder: (context, state) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if (state.isPlaying) {
                            _stopAudio();
                            return;
                          }
                          _playAudio();
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DCachedImage(
                              url: state.currentSound.image,
                              borderRadius: BorderRadius.circular(10.sp),
                              width: 100.w,
                              height: 100.h,
                            ),
                            Icon(
                              state.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                              size: 24.sp,
                              color: AppColorLight.surface,
                            ),
                          ],
                        ),
                      ),
                      18.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            context.text.originalAudio,
                            style: AppStyle.text20.copyWith(fontWeight: FontWeight.w500),
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              AppText(
                                "${context.text.by}: @${state.currentSound.user.username}",
                                style: AppStyle.text16,
                              ),
                              10.horizontalSpace,
                              Icon(Icons.arrow_forward_ios, size: 12.sp),
                            ],
                          ),
                          5.verticalSpace,
                          AppText(
                            context.text.postCount(state.currentSound.postUsedCount),
                            style: AppStyle.text16.copyWith(color: AppCustomColor.greyAC),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlocBuilder<SoundCubit, SoundState>(
                      builder: (context, state) {
                        return DButton(
                          size: Size(186.w, 35.h),
                          onPressed: () {
                            context.read<SoundCubit>().updateBookmarkSound(state.currentSound.id);
                          },
                          style: AppStyle.text12.copyWith(color: AppCustomColor.orangeF5),
                          text: context.text.favorite,
                          customChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                state.currentSound.isBookmarkedByUser ? AppAsset.svg.bookmarked : AppAsset.svg.bookmark,
                                width: 16.w,
                                height: 16.h,
                                colorFilter: ColorFilter.mode(AppColorLight.surface, BlendMode.srcIn),
                              ),
                              5.horizontalSpace,
                              AppText(
                                state.currentSound.isBookmarkedByUser ? context.text.favorited : context.text.favorite,
                                style: AppStyle.text14.copyWith(color: AppColorLight.surface),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Expanded(
                  //   child: InkWell(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         AppText(context.text.listFavorite, style: AppStyle.text14),
                  //         5.horizontalSpace,
                  //         Icon(Icons.arrow_forward_ios, size: 12.sp),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
              20.verticalSpace,
              BlocBuilder<SoundCubit, SoundState>(
                builder: (context, state) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: state.currentSound.posts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 14.h,
                        childAspectRatio: 110.w / 132.h,
                      ),
                      itemBuilder: (context, index) => PostPreviewItem(post: state.currentSound.posts[index]),
                    ),
                  );
                },
              ),
              GradientButton(
                size: Size(1.sw, 50.h),
                onPressed: () {
                  Sound sound = context.read<SoundCubit>().state.currentSound;
                  context.read<CreatePostCubit>().updateSelectedSound(sound);
                  _audioPlayer.pause();
                  _audioPlayer.dispose();
                  DNavigator.replaceNamed(RouteNamed.camera);
                },
                style: AppStyle.text12.copyWith(color: AppColorLight.surface),
                customChild: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAsset.svg.volume,
                      width: 20.w,
                      height: 20.h,
                    ),
                    5.horizontalSpace,
                    AppText(
                      context.text.useThisSound,
                      style: AppStyle.text16.copyWith(color: AppColorLight.surface),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
