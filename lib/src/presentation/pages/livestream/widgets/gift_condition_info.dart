part of '../livestream.dart';

class GiftConditionInfo extends StatefulWidget {
  const GiftConditionInfo({
    super.key,
  });

  @override
  State<GiftConditionInfo> createState() => _GiftConditionInfoState();
}

class _GiftConditionInfoState extends State<GiftConditionInfo> {
  final PageController _pageController = PageController();
  late Timer _autoSwipeTimer;
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier(0);

  List<Widget> items = [
    Image.asset(AppAsset.images.coin.path),
    Image.asset(AppAsset.images.bag.path),
    Image.asset(AppAsset.images.heart.path),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
  }

  void _startAutoSwipe() {
    _autoSwipeTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      _pageIndexNotifier.value = (_pageIndexNotifier.value + 1) % 3;

      if (_pageIndexNotifier.value == 3) {
        _pageIndexNotifier.value = 0;
        _pageController.jumpToPage(0);
        return;
      }

      _pageController.animateToPage(
        _pageIndexNotifier.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoSwipeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<LiveCubit, LiveState>(
          builder: (context, state) {
            return ValueListenableBuilder(
              valueListenable: _pageIndexNotifier,
              builder: (context, pageIndex, child) {
                return DHighlightText(
                  text: '${state.getProgressCount(pageIndex)}/${state.getConditionCount(pageIndex)}',
                  highlights: ['${state.getProgressCount(pageIndex)}'],
                  style: AppStyle.text12.copyWith(color: AppColorLight.surface),
                  highlightStyles: [AppStyle.text12.copyWith(color: AppCustomColor.orangeF5)],
                );
              },
            );
          },
        ),
        5.horizontalSpace,
        SizedBox(
          width: 14.sp,
          height: 14.sp,
          child: PageView.builder(
            itemCount: items.length,
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => items[index],
          ),
        ),
      ],
    );
  }
}

