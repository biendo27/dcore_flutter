part of '../shop.dart';

class FlashSaleBanner extends StatelessWidget {
  final PageController pageController;
  const FlashSaleBanner({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Stack(
        children: [
          Positioned(
            child: BlocBuilder<FlashSaleCubit, FlashSaleState>(
              builder: (context, state) {
                return PageView(
                  controller: pageController,
                  onPageChanged: (index) {},
                  children: state.currentFlashSale.images
                      .map((e) => DCachedImage(
                            url: e,
                            width: double.infinity,
                            height: 200.h,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 5,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: context.select((FlashSaleCubit bloc) => bloc.state.currentFlashSale.images.length),
                effect: ExpandingDotsEffect(
                  dotColor: AppCustomColor.greyAC,
                  activeDotColor: AppCustomColor.orangeFE,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
