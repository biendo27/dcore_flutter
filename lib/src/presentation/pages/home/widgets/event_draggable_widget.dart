part of '../home.dart';

class EventDraggableWidget extends StatelessWidget {
  final ValueNotifier<bool> eventNotifier;
  final ValueNotifier<Offset> eventPosition;

  const EventDraggableWidget({
    super.key,
    required this.eventNotifier,
    required this.eventPosition,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveEventCubit, LiveEventState>(
      builder: (context, state) {
        if (state.liveEvent.data.isEmpty) return const SizedBox.shrink();

        return ValueListenableBuilder(
          valueListenable: eventNotifier,
          builder: (context, isShow, child) {
            if (!isShow) return const SizedBox.shrink();

            return ValueListenableBuilder(
                valueListenable: eventPosition,
                builder: (context, position, child) {
                  return Positioned(
                    left: position.dx.clamp(20.0.w, 1.sw - 110.0.w),
                    top: position.dy.clamp(20.0.h, 1.sh - 170.0.h),
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        final newPosition = position + details.delta;
                        eventPosition.value = Offset(
                          newPosition.dx.clamp(20.0.w, 1.sw - 110.0.w),
                          newPosition.dy.clamp(20.0.h, 1.sh - 170.0.h),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 90.0.w,
                            decoration: BoxDecoration(
                              color: AppColorLight.onPrimary,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColorLight.shadow.op(0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                10.verticalSpace,
                                SizedBox(
                                  height: 30.0.h,
                                  width: 50.0.w,
                                  child: Lottie.asset(
                                    AppAsset.lottie.eventLive,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                8.verticalSpace,
                                AppText(
                                  context.text.liveEvent,
                                  textAlign: TextAlign.center,
                                  style: AppStyle.text12,
                                ),
                                DButton(
                                  onPressed: () {
                                    context.read<VideoCubit>().checkAuthAndNavigate();
                                    if (AppGlobalValue.accessToken.isEmpty) return;
                                    DNavigator.goNamed(RouteNamed.livestreamEvent);
                                  },
                                  size: Size(60.0.w, 24.0.h),
                                  padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.w),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0.r)),
                                  text: context.text.register,
                                  style: AppStyle.text10.copyWith(color: AppColorLight.onPrimary),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -8,
                            right: -8,
                            child: InkWell(
                              onTap: () => eventNotifier.value = false,
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                child: Icon(Icons.close, color: AppColorLight.onPrimary, size: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        );
      },
    );
  }
}
