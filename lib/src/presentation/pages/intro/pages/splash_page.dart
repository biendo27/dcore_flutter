part of '../intro.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<ConfigCubit>().init();
    WidgetsBinding.instance.addPostFrameCallback(_initScreen);
    super.initState();
  }

  void _initScreen(_) {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      bool userPassFirstTime = await LocalStoreService.getBool(key: LocalStoreKey.userPassFirstTime) ?? false;
      if (!userPassFirstTime) {
        DNavigator.newRoutesNamed(RouteNamed.intro);
        return;
      }

      if (!mounted) return;
      context.read<UserCubit>().initApp(onDone: () {
        context.read<PostCubit>().fetchPostList(isInit: true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColorLight.surface,
        // gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: AppCustomColor.background, stops: [0, 0.14, 0.49, 0.83]),
      ),
      child: Image.asset(AppAsset.images.introIcon.path, width: 165.w).animate().fadeIn(duration: 2.seconds),
    );
  }
}
