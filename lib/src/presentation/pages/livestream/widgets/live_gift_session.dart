part of '../livestream.dart';

class LiveGiftSession extends StatelessWidget {
  const LiveGiftSession({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveGiftCubit, LiveGiftState>(
      builder: (context, state) {
        if (state.gifts.isEmpty) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: state.gifts.map((gift) {
            return LiveGiftWidget(
              key: ValueKey(gift.id),
              gift: gift,
              onAnimationComplete: () => context.read<LiveGiftCubit>().removeGift(gift),
            );
          }).toList(),
        );
      },
    );
  }
}

class LiveGiftWidget extends StatelessWidget {
  final Gift gift;
  final VoidCallback onAnimationComplete;

  static const Duration totalDuration = Duration(seconds: 5);

  static final Duration slideDuration = Duration(milliseconds: 3500);
  static final Duration fadeDuration = Duration(milliseconds: 1500);

  const LiveGiftWidget({
    super.key,
    required this.gift,
    required this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (gift.id == 0 || gift.image.isEmpty) {
      return const SizedBox.shrink();
    }
    // The content we want to animate: image + title,
    // aligned to the bottom center.
    final child = Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.fromLTRB(20.w, 170.h, 0, 0),
      child: Image.network(
        gift.effect,
        height: 150.h,
      ),
    );

    return child
        .animate()
        .scale(
          // begin: const Offset(-1, 0),
          // end: Offset.zero,
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          curve: Curves.easeOutExpo,
          duration: slideDuration,
        )
        .then(delay: Duration.zero, duration: fadeDuration)
        .fadeOut(curve: Curves.easeOut)
        .callback(callback: (_) => onAnimationComplete());
  }
}
