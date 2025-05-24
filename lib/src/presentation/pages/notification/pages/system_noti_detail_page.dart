part of '../notification.dart';

class SystemNotiDetailPage extends StatefulWidget {
  const SystemNotiDetailPage({super.key});

  @override
  State<SystemNotiDetailPage> createState() => _SystemNotiDetailPageState();
}

class _SystemNotiDetailPageState extends State<SystemNotiDetailPage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return SubLayout(
          title: state.news.title,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 220.h,
                  child: Stack(
                    children: [
                      PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {});
                          },
                          children: state.news.images
                              .map((e) => DCachedImage(
                                    url: e,
                                    width: double.infinity,
                                    borderRadius: BorderRadius.zero,
                                  ))
                              .toList()),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 11.h,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: state.news.images.length,
                            effect: ExpandingDotsEffect(
                              dotWidth: 8.w,
                              dotHeight: 8.w,
                              activeDotColor: AppCustomColor.orangeF1,
                              dotColor: AppCustomColor.greyE9,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // if (state.news.images.isNotEmpty)
                //   CachedImage(
                //     url: state.news.images.first,
                //     width: double.infinity,
                //   ),
                16.verticalSpace,
                AppText(state.news.content),
                16.verticalSpace,
                GradientButton(
                  onPressed: DNotiMessage.featureInDevelopment,
                  text: context.text.careAbout,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
