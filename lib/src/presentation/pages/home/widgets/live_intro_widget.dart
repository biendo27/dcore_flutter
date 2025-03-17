part of '../home.dart';

class LiveIntroWidget extends StatelessWidget {
  final ValueNotifier<bool> isNotifier;

  const LiveIntroWidget({
    super.key,
    required this.isNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isNotifier,
        builder: (context, isShow, child) {
          if (!isShow) return const SizedBox.shrink();

          return Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<VideoCubit>().checkAuthAndNavigate();
                  if (AppGlobalValue.accessToken.isEmpty) return;
                  DNavigator.goNamed(RouteNamed.livestreamList);
                },
                child: SizedBox(
                  height: 25.h,
                  width: 45.w,
                  child: Lottie.asset(
                    AppAsset.lottie.live4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Positioned(
              //   top: -10.h,
              //   right: -14.w,
              //   child: GestureDetector(
              //     onTap: () => isNotifier.value = false,
              //     child: Container(
              //       width: 15.w,
              //       height: 15.w,
              //       decoration: BoxDecoration(
              //         color: AppCustomColor.redD0,
              //         shape: BoxShape.circle,
              //       ),
              //       child: Icon(
              //         Icons.close,
              //         color: AppColorLight.onPrimary,
              //         size: 14.sp,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        });
  }
}
