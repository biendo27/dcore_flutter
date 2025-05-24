part of '../home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware, WidgetsBindingObserver {
  OverlayEntry? _overlayEntry;
  PageController pageController = PageController(initialPage: 0);
  ValueNotifier<bool> isShowEvent = ValueNotifier(true);
  ValueNotifier<bool> isShowLive = ValueNotifier(true);
  ValueNotifier<Offset> eventPosition = ValueNotifier(Offset(1.sw - 110.w, kToolbarHeight + 60.h));

  @override
  void initState() {
    _fetchData();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // context.read<PostCubit>().disposeVideoControllers();
    pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    context.read<VideoCubit>().pauseAllVideoControllers();
  }

  @override
  void didPopNext() {
    context.read<VideoCubit>().resumeCurrentVideoController();
  }

  @override
  void didPush() {
    context.read<VideoCubit>().pauseAllVideoControllers();
  }

  @override
  void didPop() {
    context.read<VideoCubit>().resumeCurrentVideoController();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    VideoState postState = context.read<VideoCubit>().state;
    if (postState.videoControllers.isNotEmpty) return;
    if (state == AppLifecycleState.inactive) {
      context.read<VideoCubit>().pauseAllVideoControllers();
    }
    if (state == AppLifecycleState.resumed) {
      context.read<VideoCubit>().resumeCurrentVideoController();
    }
  }

  void _fetchData() {
    // context.read<PostCubit>().fetchPostList();
    if (AppGlobalValue.accessToken.isEmpty) return;
    context.read<SoundCubit>()
      ..fetchSoundSuggestedList()
      ..fetchSoundBookmarked();

    context
      ..read<ReportCubit>().fetchReportList(ReportType.post)
      ..read<GiftCubit>().fetchGiftList()
      ..read<WalletCubit>().walletPackage(onSuccess: (productIds) {
        AppConfig.context!.read<InAppCubit>().init(productIds);
      });

    context.read<WalletCubit>()
      ..fetchWallet(1)
      ..walletPolicy()
      ..walletPaymentMethod()
      ..walletPackage();

    context.read<LiveEventCubit>().getLiveEventList(isInit: true);

    context
      ..read<StoreHomeCubit>().fetchStoreHome()
      ..read<LiveSocketCubit>().initSocket()
      ..read<PageCubit>().handleRoute();
  }

  void _showHeartOverlay(BuildContext context, Offset position) {
    _overlayEntry = _createOverlayEntry(context, position);
    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(Duration(milliseconds: 800), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context, Offset position) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx - 24.w,
        top: position.dy - 24.h,
        child: HeartAnimation(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppCustomColor.greyF5,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildBody(),
          EventDraggableWidget(
            eventNotifier: isShowEvent,
            eventPosition: eventPosition,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiveIntroWidget(isNotifier: isShowLive),
          Spacer(),
          IconVideo(
            icon: AppAsset.svg.search,
            width: 20.w,
            height: 20.h,
            onTap: () {
              DNavigator.goNamed(RouteNamed.search);
              context.read<SearchCubit>()
                ..reset()
                ..fetchSearchHistory();
              context.read<HomeSearchCubit>().reset();
            },
          ),
          10.horizontalSpace,
          IconVideo(
            icon: AppAsset.svg.more,
            width: 20.w,
            height: 20.h,
            onTap: () {
              context.read<VideoCubit>().checkAuthAndNavigate();
              if (AppGlobalValue.accessToken.isEmpty) return;
              _viewReport();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostCubit, PostState>(
          listenWhen: (previous, current) => previous.posts != current.posts,
          listener: (context, state) {
            // if (state.posts.isNotEmpty && state.videoControllers.isEmpty) {
            //   context.read<PostCubit>().initializeVideoControllers();
            // }
          },
        ),
        BlocListener<PageCubit, PageState>(
          listener: (context, state) {
            if (state.currentIndex != 0 || !state.isPrimaryRoute) context.read<VideoCubit>().pauseAllVideoControllers();
          },
        ),
      ],
      child: Builder(builder: (context) {
        PostState postState = context.watch<PostCubit>().state;
        VideoState videoState = context.watch<VideoCubit>().state;
        if (videoState.videoControllers.isEmpty) return const AppLoading();
        return RefreshIndicator(
          onRefresh: () async => context.read<PostCubit>().fetchPostList(isInit: true),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is! ScrollEndNotification) return false;
              if (notification.metrics.maxScrollExtent != notification.metrics.pixels) return false;
              context.read<PostCubit>().fetchPostList();
              return true;
            },
            child: PageView.builder(
              // allowImplicitScrolling: true,
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: videoState.videoControllers.length,
              onPageChanged: context.read<PostCubit>().changeCurrentIndex,
              itemBuilder: (context, index) => GestureDetector(
                onDoubleTapDown: (details) {
                  _showHeartOverlay(context, details.globalPosition);
                },
                onDoubleTap: () => context.read<PostCubit>().updateLikePost(postId: postState.posts[index].id),
                child: VideoViewItem(
                  post: postState.posts[index],
                  videoPlayerController: videoState.videoControllers[index]!,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _viewReport() {
    showDModalBottomSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      contentPadding: EdgeInsets.zero,
      isDismissible: true,
      isScrollControlled: false,
      enableDrag: false,
      bodyWidget: ReportBody(),
    );
  }
}
