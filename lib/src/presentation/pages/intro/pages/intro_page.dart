part of '../intro.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = context.read<ThemeCubit>().state.themeMaterial.colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: InkWell(
          onTap: () {
            DNavigator.newRoutesNamed(RouteNamed.home);
            LocalStoreService.setBool(key: LocalStoreKey.userPassFirstTime, value: true);
          },
          child: Align(
            alignment: Alignment.bottomRight,
            child: AppText(
              context.text.skip,
              textAlign: TextAlign.end,
              style: AppStyle.text14.copyWith(color: theme.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 26),
              width: 1.sw,
              height: 0.43.sh,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppCustomColor.gradientBackground,
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.22, 0.47, 0.78, 0.96],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
              ),
            ),
          ),
          Positioned(
            child: BlocBuilder<ConfigCubit, ConfigState>(
              builder: (context, state) {
                return PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _currentPage = index;
                    setState(() {});
                  },
                  children: state.splash.map((e) => IntroContent(imagePath: e.image, title: e.title, description: e.content)).toList(),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<ConfigCubit, ConfigState>(
                  builder: (context, state) {
                    return SmoothPageIndicator(
                      controller: _pageController,
                      count: state.splash.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Color(0xABDADADA),
                        activeDotColor: Color(0xFFFFFFFF),
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    );
                  },
                ),
                20.verticalSpace,
                DButton(
                  onPressed: () {
                    ConfigState state = context.read<ConfigCubit>().state;
                    if (_currentPage == state.splash.length - 1) {
                      DNavigator.newRoutesNamed(RouteNamed.home);
                      LocalStoreService.setBool(key: LocalStoreKey.userPassFirstTime, value: true);
                      return;
                    }
                    _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                  text: context.text.next,
                  size: Size(146.w, 50.h),
                  backgroundColor: theme.primaryContainer,
                  style: AppStyle.text14.copyWith(fontWeight: FontWeight.w600, color: theme.primary),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
