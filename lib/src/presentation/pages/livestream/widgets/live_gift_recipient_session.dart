part of '../livestream.dart';

class LiveGiftRecipientSession extends StatelessWidget {
  const LiveGiftRecipientSession({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMissionCubit, LiveMissionState>(
      builder: (context, state) {
        if (state.giftRecipient.id == 0) {
          return const SizedBox.shrink();
        }

        return LiveGiftRecipientWidget(
          user: state.giftRecipient,
          onAnimationComplete: () => context.read<LiveMissionCubit>().setGiftRecipient(AppUser()),
        );
      },
    );
  }
}

class LiveGiftRecipientWidget extends StatefulWidget {
  final AppUser user;
  final VoidCallback onAnimationComplete;

  const LiveGiftRecipientWidget({
    super.key,
    required this.user,
    required this.onAnimationComplete,
  });

  @override
  State<LiveGiftRecipientWidget> createState() => _LiveGiftRecipientWidgetState();
}

class _LiveGiftRecipientWidgetState extends State<LiveGiftRecipientWidget> {
  late ValueNotifier<int> _countdownNotifier;
  late ValueNotifier<bool> _showCountdownNotifier;
  // late ValueNotifier<bool> _showGiftAnimationNotifier;
  late ValueNotifier<bool> _showRecipientTextNotifier;

  // static final Duration giftAnimationDuration = Duration(seconds: 3);
  static final Duration slideDuration = Duration(milliseconds: 3500);
  static final Duration fadeDuration = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    _countdownNotifier = ValueNotifier(5);
    _showCountdownNotifier = ValueNotifier(true);
    // _showGiftAnimationNotifier = ValueNotifier(false);
    _showRecipientTextNotifier = ValueNotifier(false);

    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;

      _countdownNotifier.value--;

      if (_countdownNotifier.value > 0) {
        _startCountdown();
        return;
      }

      Future.delayed(Duration(milliseconds: 800), () {
        _showCountdownNotifier.value = false;
        _showRecipientTextNotifier.value = true;
        // _showGiftAnimationNotifier.value = true;

        Future.delayed(Duration(seconds: 5), () {
          if (!mounted) return;

          _showRecipientTextNotifier.value = false;
          widget.onAnimationComplete();
        });
      });
    });
  }

  @override
  void dispose() {
    _countdownNotifier.dispose();
    _showCountdownNotifier.dispose();
    // _showGiftAnimationNotifier.dispose();
    _showRecipientTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user.id == 0 || widget.user.image.isEmpty) {
      return const SizedBox.shrink();
    }

    return Center(
      child: ValueListenableBuilder<bool>(
        valueListenable: _showCountdownNotifier,
        builder: (context, showCountdown, _) {
          if (showCountdown) {
            return _buildCountdownWidget();
          }

          return ValueListenableBuilder<bool>(
            valueListenable: _showRecipientTextNotifier,
            builder: (context, showRecipientText, _) {
              if (showRecipientText) {
                return _buildRecipientTextWidget();
              }

              return SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  Widget _buildCountdownWidget() {
    return ValueListenableBuilder<int>(
      valueListenable: _countdownNotifier,
      builder: (context, countdown, _) {
        return AppText(
          '$countdown',
          style: AppStyle.textCustom.copyWith(color: AppColorLight.primary),
        )
            .animate()
            .fadeIn(
              duration: Duration(milliseconds: 300),
            )
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1, 1),
              curve: Curves.easeOut,
              duration: Duration(milliseconds: 500),
            );
      },
    );
  }

  // Widget _buildGiftAnimationWidget() {
  //   return Container(
  //     alignment: Alignment.center,
  //     child: Image.asset(AppAsset.gif.gift.path, height: 150.h),
  //   )
  //       .animate()
  //       .scale(
  //         begin: const Offset(0, 0),
  //         end: const Offset(1, 1),
  //         curve: Curves.easeOutExpo,
  //         duration: slideDuration,
  //       )
  //       .then(delay: Duration.zero, duration: fadeDuration)
  //       .fadeOut(curve: Curves.easeOut);
  // }

  Widget _buildRecipientTextWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            AppAsset.gif.giftOpen.path,
            height: 160.h,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 0.65.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.op(0.7),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16), // Thêm khoảng cách trong
                  child: DHighlightText(
                    text: context.text.happyLive,
                    style: AppStyle.textBold18.copyWith(color: AppColorLight.primary),
                    highlights: [context.text.happyLive],
                    highlightStyles: [AppStyle.textBold18.copyWith(color: AppColorLight.primary)],
                    maxLines: 2,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3), // Thêm khoảng cách trong
                  child: DHighlightText(
                    text: context.text.happyLiveCap,
                    style: AppStyle.textBold14.copyWith(color: AppColorLight.primary),
                    highlights: [context.text.happyLive],
                    highlightStyles: [AppStyle.textBold14.copyWith(color: AppColorLight.primary)],
                    maxLines: 2,
                  ),
                ),
              ),
              Container(
                width: 0.4.sw,
                height: 0.1.sw,
                margin: EdgeInsets.only(left: 10, top: 8),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.op(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(AppAsset.images.walletBackground.path),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Hiệu ứng avatar
                    AnimatedScale(
                      scale: 1.2, // Tăng kích thước avatar
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                      child: widget.user.avatarWidget(
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                    10.horizontalSpace,
                    // Hiệu ứng text
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        child: DHighlightText(
                          text: widget.user.username,
                          style: AppStyle.textBold16.copyWith(color: AppColorLight.onPrimary),
                          highlights: [widget.user.username],
                          highlightStyles: [AppStyle.textBold16.copyWith(color: AppColorLight.onPrimary)],
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          curve: Curves.easeOutExpo,
          duration: slideDuration,
        )
        .then(delay: Duration.zero, duration: fadeDuration)
        .fadeOut(curve: Curves.easeOut);
  }
}
